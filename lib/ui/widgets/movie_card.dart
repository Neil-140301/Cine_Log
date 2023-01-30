import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
      {super.key,
      required this.name,
      required this.director,
      required this.url});

  final String name;
  final String director;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  url,
                  width: 200,
                  height: 200,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(director)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
