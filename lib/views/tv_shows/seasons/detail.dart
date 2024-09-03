import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yeez/models/season.dart';
import 'package:yeez/utils/tmdb_api/tmdb_config.dart';
import 'package:yeez/utils/tmdb_api/tv_show_api.dart';
import 'package:yeez/views/widgets/star_rating.dart';

class SeasonDetail extends StatefulWidget {
  final int tvShowId;
  final int seasonNumber;

  const SeasonDetail({super.key, required this.tvShowId, required this.seasonNumber});

  @override
  State<SeasonDetail> createState() => _SeasonDetail();
}

class _SeasonDetail extends State<SeasonDetail> {
  late int tvShowId = widget.tvShowId;
  late int seasonNumber = widget.seasonNumber;
  Season? season;

  @override
  void initState() {
    super.initState();
    getTvSeasonDetail();
  }

  Future<void> getTvSeasonDetail() async {
    try {
      final seasonResponse = await TvShowApi.getTvSeasonDetail(tvShowId.toString(), seasonNumber.toString());
      setState(() {
        season = seasonResponse;
      });
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: season != null ?
      Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(season!.posterPath ?? ''),
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
                              season!.posterPath ?? '',
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
                                  season!.title ?? '',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                                ),
                                const SizedBox(height: 8),

                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      season!.overview == '' ? Container() :
                        Column(
                          children: [
                          Text(
                            'Overview',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            season!.overview ?? '',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          StarRating(rating: season!.voteAverage! / 2),
                          const SizedBox(width: 4),
                          Text(
                            '${season!.voteAverage.toString()} / 10',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      season!.airDate == '' ? Container() :
                      Row(
                        children: [
                          const Text(
                            'Last air date: ',
                            style: TextStyle(color: Colors.white70)
                          ),
                          Text(season!.airDate ?? '',
                            style: const TextStyle(color: Colors.white70)
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('${season!.episodes?.length} episodes'),
                      const SizedBox(height: 16),
                      ExpansionTile(
                        initiallyExpanded: true,
                        title: const Text('Episodes', style: TextStyle(color: Colors.white70)),
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('${season!.episodes?[index].title}'),
                                subtitle: Text(season!.episodes?[index].overview ?? ''),
                                isThreeLine: true,
                                leading: season!.posterPath != null ?
                                Image.network(ApiConfig.imageBaseUrl + season!.posterPath!, width: 100, height: 100, fit: BoxFit.cover) :
                                Container(
                                  color: Colors.grey,
                                  child: const Icon(Icons.tv, color: Colors.white, size: 50),
                                ),
                              );
                            },
                            itemCount: season!.episodes?.length,
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
      const CircularProgressIndicator(),
    );
  }
}