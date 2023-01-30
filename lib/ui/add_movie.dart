import 'package:cine_log/data/movies.dart';
import 'package:cine_log/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AddMovie extends StatelessWidget {
  const AddMovie({Key? key}) : super(key: key);

  addMovie(Movie newMovie) async {
    Box<Movie> box = Hive.box<Movie>(movieBoxName);
    await box.add(newMovie);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var directorController = TextEditingController();
    var urlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new movie"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          children: [
            InputField(controller: nameController, label: "Name"),
            const SizedBox(
              height: 20,
            ),
            InputField(controller: directorController, label: "Director"),
            const SizedBox(
              height: 20,
            ),
            InputField(controller: urlController, label: "Movie Thumbnail"),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
                onPressed: () {
                  addMovie(Movie(
                      name: nameController.text.trim(),
                      director: directorController.text.trim(),
                      url: urlController.text.trim()));
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Add", style: TextStyle(fontSize: 18)),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.arrow_right_alt_sharp)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
