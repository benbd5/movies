import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_app/database/watchlist.dart';
import 'package:movies_app/models/tv_show.dart';
import 'package:movies_app/utils/isar_service.dart';
import 'package:movies_app/utils/tmdb_api/tmdb_config.dart';
import 'package:movies_app/utils/tmdb_api/tv_show_api.dart';
import 'package:movies_app/views/seasons/detail.dart';
import 'package:movies_app/views/widgets/add_to_watchlist_button.dart';
import 'package:movies_app/views/widgets/star_rating.dart';

class TvShowDetail extends StatefulWidget {
  final int tvShowId;

  const TvShowDetail({super.key, required this.tvShowId});

  @override
  State<TvShowDetail> createState() => _TvShowDetailState();
}

class _TvShowDetailState extends State<TvShowDetail> {
  final IsarService isarService = IsarService();
  late int tvShowId = widget.tvShowId;
  late bool isFavorite = false;
  TvShow? tvShow;

  @override
  void initState() {
    getTvShowDetail();
    _isFavorite();
    super.initState();
  }

  Future<void> getTvShowDetail() async {
    try {
      final tvShowResponse = await TvShowApi.getTvShowDetail(tvShowId.toString());
      setState(() {
        tvShow = tvShowResponse;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateWatchList() async {
    try {
      final watchlist = Watchlist()
        ..watchId = tvShowId
        ..type = 'tv_show';
      await isarService.addWatchlistToFavorite(watchlist);
      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _isFavorite() async {
    bool response = await isarService.isFavorite(tvShowId);
    setState(() {
      isFavorite = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tvShow != null ?
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(tvShow!.posterPath ?? ''),
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
                                tvShow!.posterPath ?? '',
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
                                    tvShow!.title ?? '',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    tvShow!.genres.map((genre) => genre.name).join(', '),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('${tvShow!.numberOfSeasons.toString()} seasons',
                                      style: const TextStyle(color: Colors.white70)
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(tvShow!.originalLanguage,
                                          style: const TextStyle(color: Colors.white70)
                                      ),
                                      const Text('/',
                                          style: TextStyle(color: Colors.white70)
                                      ),
                                      Text(tvShow!.originCountry.join(', '),
                                          style: const TextStyle(color: Colors.white70)
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Overview',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tvShow!.overview ?? '',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            StarRating(rating: tvShow!.voteAverage / 2),
                            const SizedBox(width: 4),
                            Text(
                              '${tvShow!.voteAverage.toStringAsFixed(1)} / 10',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            Text(
                                '(${tvShow!.voteCount.floor()} votes)',
                                style: const TextStyle(color: Colors.white70)
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Text(
                              'Last air date: ',
                                style: TextStyle(color: Colors.white70)
                            ),
                            Text(tvShow!.lastAirDate,
                                style: const TextStyle(color: Colors.white70)
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ExpansionTile(
                          title: const Text('Season list', style: TextStyle(color: Colors.white70)),
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text('Season ${tvShow!.seasons[index].seasonNumber}'),
                                  subtitle: Text(tvShow!.seasons[index].title ?? ''),
                                  leading: tvShow?.seasons[index].posterPath != null ?
                                    Image.network(ApiConfig.imageBaseUrl + tvShow!.seasons[index].posterPath!, width: 100, height: 100, fit: BoxFit.cover) :
                                    Container(
                                      color: Colors.grey,
                                      child: const Icon(Icons.tv, color: Colors.white, size: 50),
                                    ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => SeasonDetail(seasonId: tvShow!.id, seasonNumber: tvShow!.seasons[index].seasonNumber)));
                                  },
                                );
                              },
                              itemCount: tvShow!.numberOfSeasons,
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
      const Center(child: CircularProgressIndicator()),
      floatingActionButton: AddToWatchlistButton(
        isFavorite: isFavorite,
        updateWatchList: updateWatchList,
      ),
    );
  }
}

