import 'package:movies_app/utils/tmdb_api/tmdb_config.dart';

import 'movie.dart';

class SearchMovieList {
  final int id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final double? voteAverage;
  final double? voteCount;

  SearchMovieList({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  factory SearchMovieList.fromJson(Map<String, dynamic> json) {
    return SearchMovieList(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'] == null ? null : ApiConfig.imageBaseUrl + json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'].toDouble(),
    );
  }

  factory SearchMovieList.fromMovie(Movie movie) {
    return SearchMovieList(
      id: movie.tmdbId!,
      title: movie.title,
      overview: movie.overview,
      releaseDate: movie.releaseDate,
      posterPath: movie.posterPath,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    );
  }
}
