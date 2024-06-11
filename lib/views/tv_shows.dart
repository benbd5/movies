import 'package:flutter/material.dart';
import 'package:movies_app/models/tv_show_list.dart';
import 'package:movies_app/utils/tmdb_api/tv_show_api.dart';
import 'package:movies_app/views/tv_shows/list.dart';
import 'package:movies_app/views/widgets/bottom_navigation_bar.dart';
import 'package:movies_app/views/widgets/shimmer_loader.dart';

class TvShows extends StatefulWidget {
  const TvShows({super.key});
  
  @override
  State<TvShows> createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  late List<TvShowList> popularTvShows = [];

  @override
  void initState() {
    super.initState();
    getPopularTvShows();
  }
  
  Future<void> getPopularTvShows() async {
    try {
      final List<TvShowList> getTvShows = await TvShowApi.getPopularTvShows();
      setState(() {
        popularTvShows = getTvShows;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(selectedIndex: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            popularTvShows.isEmpty ? const ShimmerLoader() : TvShowsList(tvShows: popularTvShows),
          ],
        ),
      ),
    );
  }
}