import 'package:flutter/material.dart';
import 'package:movies_app/enum/type_enum.dart';
import 'package:movies_app/models/carousel_list.dart';
import 'package:movies_app/models/movie_list.dart';
import 'package:movies_app/views/widgets/carousel.dart';

class CarouselMovies extends StatelessWidget {
  final List<MovieList> movies;
  const CarouselMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final List<CarouselList> carouselList = movies
      .map((movie) => CarouselList(
        id: movie.id,
        posterPath: movie.posterPath,
        type: TypeEnum.movie,
        length: movies.length,
        )
      ).toList();

    return CarouselWidget(carouselList: carouselList, context: context);
  }
}