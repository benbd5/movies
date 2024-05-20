import 'package:isar/isar.dart';

@embedded
class Genre {
  int? tmdbId;
  String? name;

  Genre({
    this.tmdbId,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      tmdbId: json['id'],
      name: json['name'],
    );
  }
}