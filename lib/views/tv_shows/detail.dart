import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/models/tv_show.dart';
import 'package:movies_app/utils/tmdb_api/tmdb_config.dart';
import 'package:movies_app/utils/tmdb_api/tv_show_api.dart';
import 'package:movies_app/views/seasons/detail.dart';
import 'package:movies_app/views/widgets/star_rating.dart';

class TvShowDetail extends StatefulWidget {
  final int tvShowId;

  const TvShowDetail({super.key, required this.tvShowId});

  @override
  State<TvShowDetail> createState() => _TvShowDetailState();
}

class _TvShowDetailState extends State<TvShowDetail> {
  late int tvShowId = widget.tvShowId;
  TvShow? tvShow;

  @override
  void initState() {
    super.initState();
    getTvShowDetail();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: tvShow != null
          ? CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: tvShow?.backdropPath != null ?
                Image.network(tvShow!.backdropPath ?? '', fit: BoxFit.cover) :
                const SizedBox(),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: Colors.black26,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black26),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image.network(tvShow.posterPath),
                    Text(tvShow!.title),
                    Text(tvShow!.genres.map((genre) => genre.name).join(', ')),
                    Text(tvShow!.lastAirDate),
                    Text('${tvShow!.voteAverage.toStringAsFixed(1).toString()} / 10'),
                    Text('${(tvShow!.voteAverage / 2).toStringAsFixed(1).toString()} / 5'),
                    StarRating(rating: tvShow!.voteAverage / 2),
                    Text('${tvShow!.voteCount.floor().toString()} votes'),
                    Text(tvShow!.status),
                    Text(tvShow!.originalLanguage),
                    Text(tvShow!.originCountry.join(', ')),
                    Text(tvShow!.overview),
                    Text('${tvShow!.numberOfSeasons.toString()} seasons'),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SeasonDetail(seasonId: tvShow!.id, seasonNumber: tvShow!.seasons[index].seasonNumber)));
                          },
                          child:
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: tvShow?.seasons[index].posterPath != null ?
                                Image.network(ApiConfig.imageBaseUrl + tvShow!.seasons[index].posterPath!, fit: BoxFit.fill) :
                                Container(
                                  color: Colors.grey,
                                  child: const Icon(Icons.tv, color: Colors.white, size: 50),
                                ),
                              ),
                            ),
                        );
                      },
                      itemCount: tvShow!.numberOfSeasons,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
        : const Center(child: CircularProgressIndicator()),
    );
  }
}