import 'package:flutter/material.dart';
import 'package:movies_app/models/tv_show_list.dart';
import 'package:movies_app/views/tv_shows/tv_show_tile.dart';

class TvShowsList extends StatelessWidget {
  final List<TvShowList> tvShows;
  const TvShowsList({super.key, required this.tvShows});

  @override
  Widget build(BuildContext context) {
    return TvShowTile(tvShows: tvShows, context: context);
  }
}