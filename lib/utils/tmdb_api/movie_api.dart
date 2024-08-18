import 'package:http/http.dart' as http;
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/movie_list.dart';
import 'package:movies_app/models/search_movies_list.dart';
import 'dart:convert';

import '../tmdb_api/tmdb_config.dart';
import '../../models/movie.dart';

class MovieApi {
  static Future<List<MovieList>> getPopularMovies() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/popular?include_adult=false&api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => MovieList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<List<MovieList>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/upcoming?include_adult=false&api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => MovieList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<List<MovieList>> getDiscoverMovies(int selectedMonths) async {
    final firstDate = DateTime.now().toIso8601String().split('T')[0];
    final endDate = DateTime.now().add(Duration(days: selectedMonths * 30)).toIso8601String().split('T')[0];

    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/discover/movie?include_adult=false&primary_release_date.gte=$firstDate&primary_release_date.lte=$endDate&sort_by=popularity.desc&api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => MovieList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<Movie> getMovieDetail(String movieId) async {
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

  static Future<List<Genre>> getGenres() async {
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

  static Future<List<MovieList>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/movie/now_playing?include_adult=false&api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => MovieList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  static Future<List<SearchList>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/search/movie?include_adult=false&query=$query&api_key=${ApiConfig.apiKey}',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => SearchList.fromMoviesJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
