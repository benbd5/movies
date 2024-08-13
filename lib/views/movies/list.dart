import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_list.dart';

import 'movie_tile.dart';

class MoviesList extends StatelessWidget {
  final List<MovieList> movies;
  const MoviesList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return MovieTile(movies: movies, context: context);
  }
}
