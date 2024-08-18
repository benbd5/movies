import 'package:flutter/material.dart';
import 'package:movies_app/enum/type_enum.dart';
import 'package:movies_app/models/carousel_list.dart';
import 'package:movies_app/models/tv_show_list.dart';
import 'package:movies_app/views/widgets/carousel.dart';

class CarouselTvShows extends StatelessWidget {
  final List<TvShowList> tvShows;
  const CarouselTvShows({super.key, required this.tvShows});

  @override
  Widget build(BuildContext context) {
    final List<CarouselList> carouselList = tvShows
      .map((movie) => CarouselList(
        id: movie.id,
        posterPath: movie.posterPath,
        type: TypeEnum.tvShow,
        length: tvShows.length,
        )
      ).toList();

    return CarouselWidget(carouselList: carouselList, context: context);
  }
}