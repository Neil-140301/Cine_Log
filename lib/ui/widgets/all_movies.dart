import 'package:cine_log/data/movies.dart';
import 'package:cine_log/ui/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({super.key});

  deleteMovie(String key) async {
    Box<Movie> box = Hive.box<Movie>(movieBoxName);
    await box.delete(key);
  }

  Widget deleteAction({bool right = false}) => Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: right ? Alignment.centerRight : Alignment.centerLeft,
        color: Colors.redAccent,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: ValueListenableBuilder(
            valueListenable: Hive.box<Movie>(movieBoxName).listenable(),
            builder: (context, moviesBox, _) {
              if (moviesBox.values.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/empty_list.svg',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "No movies yet.",
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                );
              }

              return ListView.builder(
                  itemCount: moviesBox.length,
                  itemBuilder: (context, index) {
                    Movie movie = moviesBox.getAt(index)!;

                    return Dismissible(
                      key: ObjectKey(index),
                      background: deleteAction(),
                      secondaryBackground: deleteAction(right: true),
                      confirmDismiss: (direction) async {
                        await moviesBox.deleteAt(index);
                        Get.snackbar(
                          "Movie",
                          "Deleted successfully",
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.only(
                              bottom: 60, left: 10, right: 10),
                        );
                        return Future.delayed(
                            const Duration(milliseconds: 800), () => true);
                      },
                      child: MovieCard(
                          name: movie.name,
                          director: movie.director,
                          url: movie.url),
                    );
                  });
            }),
      ),
    );
  }
}
