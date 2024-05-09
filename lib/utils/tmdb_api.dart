import 'package:http/http.dart' as http;
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/movie_list.dart';
import 'dart:convert';

import 'tmdb_config.dart';
import '../models/movie.dart';

class MovieService {
  static Future<List<MovieList>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/popular?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => MovieList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<Movie> fetchMovieDetail(String movieId) async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/$movieId?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<List<Genre>> fetchGenres() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/genre/movie/list?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['genres'];
      return results.map((json) => Genre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch genres');
    }
  }
}
