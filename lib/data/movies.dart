import 'package:hive_flutter/hive_flutter.dart';

part 'movies.g.dart';

@HiveType(typeId: 0)
class Movie {
  Movie({required this.name, required this.director, required this.url});

  @HiveField(0)
  String name;

  @HiveField(1)
  String director;

  @HiveField(2)
  String url;
}

String movieBoxName = 'movies';
