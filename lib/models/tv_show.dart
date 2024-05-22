import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/season_list.dart';
import 'package:movies_app/utils/tmdb_api/tmdb_config.dart';

class TvShow {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String lastAirDate;
  final double voteAverage;
  final double voteCount;
  final List<Genre> genres;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final List<int> episodeRuntime;
  final String status;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<SeasonList> seasons;

  TvShow({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.lastAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.episodeRuntime,
    required this.status,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      id: json['id'],
      title: json['name'],
      overview: json['overview'],
      lastAirDate: json['last_air_date'],
      posterPath: json['poster_path'] == null ? null : ApiConfig.imageBaseUrl + json['poster_path'],
      backdropPath: json['backdrop_path'] == null ? null : ApiConfig.imageBaseUrl + json['backdrop_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'].toDouble(),
      genres: List<Genre>.from(json['genres'].map((genre) => Genre.fromJson(genre))),
      imdbId: json['imdb_id'] ?? '',
      originCountry: List<String>.from(json['origin_country'].map((country) => country)),
      originalLanguage: json['original_language'],
      episodeRuntime: [],
      status: json['status'] ?? '',
      numberOfEpisodes: json['number_of_episodes'],
      numberOfSeasons: json['number_of_seasons'],
      seasons: List<SeasonList>.from(json['seasons']?.map((season) => SeasonList.fromJson(season))),
    );
  }
}