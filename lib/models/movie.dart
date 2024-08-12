import 'package:isar/isar.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/utils/tmdb_api/tmdb_config.dart';

@embedded
class Movie {
  int? tmdbId;
  String? title;
  String? overview;
  String posterPath;
  String? backdropPath;
  String? releaseDate;
  double? voteAverage;
  double? voteCount;
  List<Genre>? genres = [];
  String? imdbId;
  List<String>? originCountries;
  String? originalLanguage;
  int? runtime;
  String? status;

  Movie({
    this.tmdbId,
    this.title,
    this.overview,
    required this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.genres,
    this.imdbId,
    this.originCountries,
    this.originalLanguage,
    this.runtime,
    this.status,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      tmdbId: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'] == null ? '' : ApiConfig.imageBaseUrl + json['poster_path'],
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
