class Episode {
  final int id;
  final String? airDate;
  final int? episodeNumber;
  final String? title;
  final String? overview;
  final String? stillPath;
  final int? runtime;
  final int? seasonNumber;
  final double? voteAverage;
  final int? voteCount;

  Episode({
    required this.id,
    required this.airDate,
    required this.episodeNumber,
    required this.title,
    required this.overview,
    required this.stillPath,
    required this.runtime,
    required this.seasonNumber,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      airDate: json['air_date'],
      episodeNumber: json['episode_number'],
      title: json['name'],
      overview: json['overview'],
      stillPath: json['still_path'],
      runtime: json['runtime'],
      seasonNumber: json['season_number'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}