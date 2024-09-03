import 'package:flutter/material.dart';
import 'package:yeez/enum/type_enum.dart';
import 'package:yeez/models/tv_show_list.dart';
import 'package:yeez/utils/tmdb_api/tv_show_api.dart';
import 'package:yeez/views/search/animated_search_view.dart';
import 'package:yeez/views/tv_shows/carousel_tv_shows.dart';
import 'package:yeez/views/tv_shows/list.dart';
import 'package:yeez/views/widgets/bottom_navigation_bar.dart';
import 'package:yeez/views/widgets/shimmer_loader.dart';

class TvShows extends StatefulWidget {
  const TvShows({super.key});
  
  @override
  State<TvShows> createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  late List<TvShowList> popularTvShows = [];
  late List<TvShowList> discoverTvShows = [];
  int selectedMonths = 1;

  @override
  void initState() {
    super.initState();
    getPopularTvShows();
    getUpcomingTvShows();
  }
  
  Future<void> getPopularTvShows() async {
    try {
      final List<TvShowList> getTvShows = await TvShowApi.getPopularTvShows();
      setState(() {
        popularTvShows = getTvShows;
      });
    } catch (e) {}
  }

  Future<void> getUpcomingTvShows() async {
    try {
      final List<TvShowList> getTvShows = await TvShowApi.getDiscoverTvShows(selectedMonths);
      setState(() {
        discoverTvShows = getTvShows;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(selectedIndex: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            popularTvShows.isEmpty ? const ShimmerLoader() : CarouselTvShows(tvShows: popularTvShows),
            Row(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Upcoming TvShows', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                const SizedBox(width: 16),
                DropdownButton<int>(
                  dropdownColor: Colors.black87,
                  value: selectedMonths,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('1 Month')),
                    DropdownMenuItem(value: 3, child: Text('3 Months')),
                    DropdownMenuItem(value: 6, child: Text('6 Months')),
                    DropdownMenuItem(value: 12, child: Text('12 Months')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedMonths = value!;
                      getUpcomingTvShows();
                    });
                  },
                ),
              ],
            ),
            discoverTvShows.isEmpty ? const ShimmerLoader() : TvShowsList(tvShows: discoverTvShows),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AnimatedSearchView.show(context, TypeEnum.tvShow);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}