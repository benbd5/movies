import 'package:isar/isar.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/movie_list.dart';
import 'package:movies_app/utils/tmdb_api/tmdb_config.dart';

part 'movie.g.dart';

@collection
class Movie {
  Id id = Isar.autoIncrement;
  int? tmdbId;
  String? title;
  String? overview;
  String? posterPath;
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
    this.posterPath,
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
      posterPath: json['poster_path'] == null ? null : ApiConfig.imageBaseUrl + json['poster_path'],
      backdropPath: json['backdrop_path'] == null ? null : ApiConfig.imageBaseUrl + json['backdrop_path'],
      voteAverage: json['vote_average']?.toDouble(),
      voteCount: json['vote_count']?.toDouble(),
      genres: json['genres'] != null
          ? List<Genre>.from(json['genres'].map((genre) => Genre.fromJson(genre)))
          : null,
      imdbId: json['imdb_id'],
      originCountries: json['origin_country'] != null
          ? List<String>.from(json['origin_country'])
          : null,
      originalLanguage: json['original_language'],
      runtime: json['runtime'],
      status: json['status'],
    );
  }

  factory Movie.fromMovieList(MovieList movie) {
    return Movie(
      tmdbId: movie.id,
      title: movie.title,
      overview: movie.overview,
      releaseDate: movie.releaseDate,
      posterPath: movie.posterPath,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    );
  }
}