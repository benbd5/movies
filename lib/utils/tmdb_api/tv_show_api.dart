import 'package:http/http.dart' as http;
import 'package:yeez/models/search_movies_list.dart';
import 'package:yeez/models/season.dart';
import 'package:yeez/models/tv_show.dart';
import 'package:yeez/models/tv_show_list.dart';
import 'dart:convert';
import '../tmdb_api/tmdb_config.dart';

class TvShowApi {
  static Future<List<TvShowList>> getPopularTvShows() async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/tv/popular?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => TvShowList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch tv shows');
    }
  }

  static Future<TvShow> getTvShowDetail(String tvShowId) async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/tv/$tvShowId?api_key=${ApiConfig.apiKey}',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return TvShow.fromJson(data);
    } else {
      throw Exception('Failed to fetch tv shows');
    }
  }

  static Future<Season> getTvSeasonDetail(String tvShowId, String seasonNumber) async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/tv/$tvShowId/season/$seasonNumber?api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Season.fromJson(data);
    } else {
      throw Exception('Failed to fetch tv season details');
    }
  }

  static Future<List<TvShowList>> getDiscoverTvShows(int selectedMonths) async {
    final firstDate = DateTime.now().toIso8601String().split('T')[0];
    final endDate = DateTime.now().add(Duration(days: selectedMonths * 30)).toIso8601String().split('T')[0];

    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/discover/tv?include_adult=false&first_air_date.gte=$firstDate&first_air_date.lte=$endDate&sort_by=popularity.desc&api_key=${ApiConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => TvShowList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch tv shows');
    }
  }

  static Future<List<SearchList>> searchTvShows(String query) async {
    final response = await http.get(Uri.parse(
      '${ApiConfig.baseUrl}/search/tv?query=$query&api_key=${ApiConfig.apiKey}',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => SearchList.fromTvShowsJson(json)).toList();
    } else {
      throw Exception('Failed to fetch tv shows');
    }
  }
}
