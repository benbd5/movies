import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movie_list.dart';
import 'package:movies_app/models/tv_show.dart';
import 'package:movies_app/models/tv_show_list.dart';
import 'package:movies_app/utils/isar_service.dart';
import 'package:movies_app/views/movies/list.dart';
import 'package:movies_app/views/tv_shows/list.dart';
import 'package:movies_app/views/widgets/bottom_navigation_bar.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  final IsarService isarService = IsarService();

  Future<Map<String, List>> _fetchWatchlistItems() async {
    List<Movie> movies = await isarService.getAllMovies();
    List<TvShow> tvShows = await isarService.getAllTvShows();

    return {
      'movies': movies.map((movie) => MovieList.fromMovie(movie)).toList(),
      'tvShows': tvShows.map((tvShow) => TvShowList.fromTvShow(tvShow)).toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const BottomNavigation(selectedIndex: 2),
      body: FutureBuilder<Map<String, List>>(
        future: _fetchWatchlistItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data!['movies']!.isEmpty && snapshot.data!['tvShows']!.isEmpty)) {
            return const Center(child: Text('Your watchlist is empty'));
          } else {
            List<MovieList> movies = snapshot.data!['movies'] as List<MovieList>;
            List<TvShowList> tvShows = snapshot.data!['tvShows'] as List<TvShowList>;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (movies.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Movies',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    MoviesList(movies: movies),
                  ],
                  if (tvShows.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'TV Shows',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TvShowsList(tvShows: tvShows),
                  ],
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
