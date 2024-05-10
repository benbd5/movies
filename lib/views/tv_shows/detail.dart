import 'package:flutter/material.dart';
import 'package:movies_app/models/tv_show.dart';
import 'package:movies_app/utils/tmdb_api/tv_show_api.dart';

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
    // int hours = tvShow != null ? tvShow!.runtime ~/ 60 : 0;
    // int minutes = tvShow != null ? tvShow!.runtime % 60 : 0;

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
                child: Column(
                  children: [
                    // Image.network(tvShow.posterPath),
                    Text(tvShow!.title),
                    Text(tvShow!.genres.map((genre) => genre.name).join(', ')),
                    Text(tvShow!.lastAirDate),
                    Text('${tvShow!.voteAverage.toStringAsFixed(1).toString()} / 10'),
                    Text('${tvShow!.voteCount.floor().toString()} votes'),
                    // Text('$hours h $minutes min'),
                    Text(tvShow!.status),
                    Text(tvShow!.originalLanguage),
                    Text(tvShow!.originCountry.join(', ')),
                    Text(tvShow!.overview),
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