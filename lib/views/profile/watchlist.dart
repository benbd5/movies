import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movie_list.dart';
import 'package:movies_app/utils/isar_service.dart';
import 'package:movies_app/utils/tmdb_api/movie_api.dart';
import 'package:movies_app/views/movies/detail.dart';
import 'package:movies_app/views/movies/movie_tile.dart';
import 'package:movies_app/views/widgets/bottom_navigation_bar.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  final IsarService isarService = IsarService();
  late IsarCollection<Watchlist>? watchlist;
  late Future<List<MovieList>>? _movieDetailsFuture;

  List<MovieList> moviesList = [];

  @override
  void initState() {
    _movieDetailsFuture = _getMovieDetails();
    super.initState();
  }

  Future<List<MovieList>> _getMovieDetails() async {
    final watchlistIds = await isarService.getAllWatchlists();
    final movieDetails = <Movie>[];

    for (final watchlistId in watchlistIds) {
      final details = await MovieApi.getMovieDetail(watchlistId.watchId.toString());
      movieDetails.add(details);
    }

    return transformToMovieList(movieDetails);
  }

  List<MovieList> transformToMovieList(List<Movie> movies) {
    return movies.map((movie) => MovieList.fromMovie(movie)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(selectedIndex: 1),
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: FutureBuilder(
        future: _movieDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MovieTile(movies: snapshot.data!, context: context);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}