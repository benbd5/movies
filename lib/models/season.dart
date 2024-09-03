import 'package:yeez/utils/tmdb_api/tmdb_config.dart';

import 'episode.dart';

class Season {
  final String id;
  final String? airDate;
  final String? title;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;
  final List<Episode>? episodes;

  Season({
    required this.id,
    required this.airDate,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
    required this.episodes,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['_id'],
      airDate: json['air_date'],
      title: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'] == null ? null : ApiConfig.imageBaseUrl + json['poster_path'],
      seasonNumber: json['season_number'],
      voteAverage: json['vote_average'],
      episodes: json['episodes']?.map<Episode>((episode) => Episode.fromJson(episode)).toList(),
    );
  }
}