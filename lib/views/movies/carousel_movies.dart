import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_list.dart';
import 'package:movies_app/views/widgets/carousel.dart';

class CarouselMovies extends StatelessWidget {
  final List<MovieList> movies;
  const CarouselMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselWidget(movies: movies, context: context);
  }
}