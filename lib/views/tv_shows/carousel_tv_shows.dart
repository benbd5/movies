import 'package:flutter/material.dart';
import 'package:yeez/enum/type_enum.dart';
import 'package:yeez/models/carousel_list.dart';
import 'package:yeez/models/tv_show_list.dart';
import 'package:yeez/views/widgets/carousel.dart';

class CarouselTvShows extends StatelessWidget {
  final List<TvShowList> tvShows;
  const CarouselTvShows({super.key, required this.tvShows});

  @override
  Widget build(BuildContext context) {
    final List<CarouselList> carouselList = tvShows
      .map((tvShow) => CarouselList(
        id: tvShow.id,
        posterPath: tvShow.posterPath,
        type: TypeEnum.tvShow,
        length: tvShows.length,
        )
      ).toList();

    return CarouselWidget(carouselList: carouselList, context: context);
  }
}