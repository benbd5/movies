import '../../utils/tmdb_config.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final double voteCount;
  final List genres;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      posterPath: ApiConfig.imageBaseUrl + json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'].toDouble(),
      genres: json['genres']?.map((genre) => genre['name']).toList() ?? [],
    );
  }
}
