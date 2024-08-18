import 'package:movies_app/models/tv_show.dart';
import 'package:movies_app/utils/tmdb_api/tmdb_config.dart';

class TvShowList {
  final int id;
  final String? title;
  final String? overview;
  final String posterPath;
  final String? firstAirDate;
  final double? voteAverage;
  final double? voteCount;

  TvShowList({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShowList.fromJson(Map<String, dynamic> json) {
    return TvShowList(
      id: json['id'],
      title: json['name'],
      overview: json['overview'],
      firstAirDate: json['first_air_date'],
      posterPath: json['poster_path'] == null ? '' : ApiConfig.imageBaseUrl + json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'].toDouble(),
    );
  }

  factory TvShowList.fromTvShow(TvShow tvShow) {
    return TvShowList(
      id: tvShow.tmdbId,
      title: tvShow.title,
      overview: tvShow.overview,
      firstAirDate: tvShow.firstAirDate,
      posterPath: tvShow.posterPath ?? '',
      voteAverage: tvShow.voteAverage,
      voteCount: tvShow.voteCount,
    );
  }
}
