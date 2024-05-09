import 'package:movies_app/models/genre.dart';
import 'package:movies_app/utils/tmdb_config.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final double voteAverage;
  final double voteCount;
  final List<Genre> genres;
  final String imdbId;
  final List<String> originCountries;
  final String originalLanguage;
  final int runtime;
  final String status;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.imdbId,
    required this.originCountries,
    required this.originalLanguage,
    required this.runtime,
    required this.status,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'] == null ? null : ApiConfig.imageBaseUrl + json['poster_path'],
      backdropPath: json['backdrop_path'] == null ? null : ApiConfig.imageBaseUrl + json['backdrop_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'].toDouble(),
      genres: List<Genre>.from(json['genres'].map((genre) => Genre.fromJson(genre))),
      imdbId: json['imdb_id'] ?? '',
      originCountries: List<String>.from(json['origin_country'].map((country) => country)),
      originalLanguage: json['original_language'],
      runtime: json['runtime'],
      status: json['status'] ?? '',
    );
  }
}
