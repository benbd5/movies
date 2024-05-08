import 'package:http/http.dart' as http;
import 'dart:convert';

import 'tmdb_config.dart';
import '../models/movie.dart';

class MovieService {
  static Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/popular?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<Movie> fetchMovieDetail(String movieId) async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/details/$movieId?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
