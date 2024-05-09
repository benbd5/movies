import 'package:movies_app/utils/tmdb_config.dart';

class MovieList {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final double voteCount;

  MovieList({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      posterPath: ApiConfig.imageBaseUrl + json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'].toDouble(),
    );
  }
}
