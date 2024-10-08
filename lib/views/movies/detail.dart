import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yeez/enum/type_enum.dart';
import 'package:yeez/utils/isar_service.dart';
import 'package:yeez/utils/tmdb_api/movie_api.dart';
import 'package:yeez/views/widgets/add_to_watchlist_button.dart';
import 'package:yeez/views/widgets/star_rating.dart';
import 'package:yeez/models/movie.dart';

class MovieDetail extends StatefulWidget {
  final int movieId;

  const MovieDetail({super.key, required this.movieId});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final IsarService isarService = IsarService();
  late int movieId = widget.movieId;
  late bool isFavorite = false;
  Movie? movie;


  @override
  void initState() {
    super.initState();
    getMovieDetail();
    _isFavorite();
  }

  Future<void> getMovieDetail() async {
    try {
      final movieResponse = await MovieApi.getMovieDetail(movieId.toString());
      setState(() {
        movie = movieResponse;
      });
    } catch (e) {}
  }

  Future<void> updateWatchList(Movie movie) async {
    try {
      if (isFavorite) {
        await isarService.deleteMovie(movie.tmdbId);
      } else {
        await isarService.saveMovie(movie);
      }

      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {}
  }

  Future<void> _isFavorite() async {
    bool response = await isarService.isFavorite(movieId, TypeEnum.movie);
    setState(() {
      isFavorite = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    int hours = movie != null ? movie!.runtime ~/ 60 : 0;
    int minutes = movie != null ? movie!.runtime % 60 : 0;

    return Scaffold(
      body: movie != null
        ? Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movie!.posterPath ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              const SliverAppBar(
                backgroundColor: Colors.transparent,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                            Image.network(
                              movie!.posterPath ?? '',
                              height: 180,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie!.title,
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie!.genres!.map((genre) => genre.name).join(', '),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, color: Colors.white70),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$hours h $minutes min',
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Overview',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie!.overview,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          StarRating(rating: movie!.voteAverage / 2),
                          const SizedBox(width: 4),
                          Text(
                            '${movie!.voteAverage.toStringAsFixed(1)} / 10',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          Text(
                              '(${movie!.voteCount.floor()} votes)',
                            style: const TextStyle(color: Colors.white70)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ) :
      const Center(child: CircularProgressIndicator()),
      floatingActionButton:
        AddToWatchlistButton(
          isFavorite: isFavorite,
          updateWatchList: updateWatchList,
          item: movie,
        ),
    );
  }
}
