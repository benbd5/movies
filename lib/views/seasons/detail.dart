import 'package:flutter/material.dart';
import 'package:movies_app/models/season.dart';
import 'package:movies_app/utils/tmdb_api/tmdb_config.dart';
import 'package:movies_app/utils/tmdb_api/tv_show_api.dart';

class SeasonDetail extends StatefulWidget {
  final int seasonId;
  final int seasonNumber;

  const SeasonDetail({super.key, required this.seasonId, required this.seasonNumber});

  @override
  State<SeasonDetail> createState() => _SeasonDetail();
}

class _SeasonDetail extends State<SeasonDetail> {
  late int tvShowId = widget.seasonId;
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
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: season != null ? SingleChildScrollView(
        child: Column(
          children: [
            Image.network(ApiConfig.imageBaseUrl + season!.posterPath!, fit: BoxFit.fill),
            Text('${season!.title}'),
            Text('Season number ${season!.seasonNumber}'),
            Text('${season!.episodes?.length} episodes'),
            Text('${season!.airDate} air date'),
            Text('${season!.voteAverage}'),
            Text('${season!.overview}'),
            SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: season!.episodes?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      width: 150,
                      child: Column(
                        children: [
                          Expanded(child:
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: season!.posterPath != null ?
                              Image.network(ApiConfig.imageBaseUrl + season!.posterPath!, fit: BoxFit.fill) :
                            //   child: season!.episodes?[index].stillPath != null ?
                            // Image.network(ApiConfig.imageBaseUrl + season!.episodes![index].stillPath!, fit: BoxFit.fill) :
                              Container(
                                color: Colors.grey,
                                width: 150,
                                child: const Icon(Icons.tv, color: Colors.white, size: 50),
                              ),
                            ),
                          ),
                          Expanded(child: Text('${season!.episodes?[index].title}')),
                        ],
                      ),
                    );
                  }),
            ),
          ]
        ),
      )
      : const CircularProgressIndicator(),
    );
  }
}