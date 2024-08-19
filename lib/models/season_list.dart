import 'package:movies_app/utils/tmdb_api/tmdb_config.dart';

class SeasonList {
  final int id;
  final String? airDate;
  final int? episodeCount;
  final String? title;
  final String? overview;
  final String? posterPath;
  final int seasonNumber;
  final double? voteAverage;

  SeasonList({
    required this.id,
    required this.airDate,
    required this.episodeCount,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory SeasonList.fromJson(Map<String, dynamic> json) {
    return SeasonList(
      id: json['id'],
      airDate: json['air_date'],
      episodeCount: json['episode_count'],
      title: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'] == null ? null : ApiConfig.imageBaseUrl + json['poster_path'],
      seasonNumber: json['season_number'],
      voteAverage: json['vote_average'],
    );
  }
}