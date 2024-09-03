import 'package:yeez/utils/tmdb_api/tmdb_config.dart';

import 'movie.dart';

class MovieList {
  final int id;
  final String? title;
  final String? overview;
  final String posterPath;
  final String? releaseDate;
  final double? voteAverage;
  final double? voteCount;

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
      posterPath: json['poster_path'] == null ? '' : ApiConfig.imageBaseUrl + json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'].toDouble(),
    );
  }

  factory MovieList.fromMovie(Movie movie) {
    return MovieList(
      id: movie.tmdbId,
      title: movie.title,
      overview: movie.overview,
      releaseDate: movie.releaseDate,
      posterPath: movie.posterPath ?? '',
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    );
  }
}
