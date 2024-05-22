import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_list.dart';
import 'package:movies_app/views/movies/detail.dart';

import 'movie_tile.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class MoviesList extends StatelessWidget {
  final List<MovieList> movies;
  const MoviesList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return MovieTile(movies: movies, context: context);
  }
}
