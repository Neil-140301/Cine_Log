import 'package:cine_log/ui/app_controller.dart';
import 'package:cine_log/ui/auth/sign_in.dart';
import 'package:cine_log/ui/widgets/all_movies.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends GetView<AppController> {
  const Home({Key? key}) : super(key: key);

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget homeView(bool isLoggedIn) {
    if (isLoggedIn) {
      return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "All Movies",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.amber.shade800,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
                DescribedFeatureOverlay(
                  featureId: 'add_movie',
                  tapTarget: const Icon(Icons.add),
                  title: const Text("Add a new movie"),
                  description: const Text(
                      "Watched a new movie recently?\n Add it to the list here."),
                  backgroundColor: Colors.deepPurpleAccent,
                  contentLocation: ContentLocation.below,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/add');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const MoviesList(),
            const DescribedFeatureOverlay(
                featureId: 'movie_list',
                tapTarget: Icon(
                  Icons.featured_play_list,
                  size: 30,
                ),
                title: Text("Movies"),
                description: Text(
                    "A list of your watched movies.\nWant to delete a movie? \nSimply slide to dismiss it."),
                backgroundColor: Colors.green,
                contentLocation: ContentLocation.above,
                child: SizedBox(
                  height: 10,
                  width: double.maxFinite,
                )),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );
    } else {
      return const DescribedFeatureOverlay(
          featureId: 'sign_in',
          tapTarget: Icon(Icons.arrow_circle_down_rounded),
          title: Text('Sign In Page'),
          description: Text(
              'You can sign in using your google account \nor by any email.'),
          child: SignIn());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: const Text(
            "CineLog",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Colors.deepOrangeAccent,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  FeatureDiscovery.discoverFeatures(
                    context,
                    const <String>{
                      // Feature ids for every feature that you want to showcase in order.
                      'sign_in',
                      'add_movie',
                      'movie_list',
                      'logout',
                    },
                  );
                },
                icon: const Icon(Icons.info)),
            Visibility(
                visible: controller.loggedIn,
                child: DescribedFeatureOverlay(
                  featureId: 'logout',
                  tapTarget: const Icon(Icons.logout),
                  title: const Text('Sign out'),
                  description: const Text("You can log out from here."),
                  backgroundColor: Colors.amberAccent,
                  child: IconButton(
                      onPressed: signOut, icon: const Icon(Icons.logout)),
                ))
          ],
        ),
        body: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: homeView(controller.loggedIn))));
  }
}
