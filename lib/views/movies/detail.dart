import 'package:flutter/material.dart';
import 'package:movies_app/database/watchlist.dart';
import 'package:movies_app/utils/isar_service.dart';
import 'package:movies_app/utils/tmdb_api/movie_api.dart';
import 'package:movies_app/views/widgets/star_rating.dart';
import '../../models/movie.dart';

class MovieDetail extends StatefulWidget {
  final int movieId;

  const MovieDetail({super.key, required this.movieId});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final IsarService isarService = IsarService();
  late int movieId = widget.movieId;
  late bool isFavorite = false;
  Movie? movie;


  @override
  void initState() {
    getMovieDetail();
    _isFavorite();
    super.initState();
  }

  Future<void> getMovieDetail() async {
    try {
      final movieResponse = await MovieApi.getMovieDetail(movieId.toString());
      setState(() {
        movie = movieResponse;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateWatchList() async {
    try {
      final watchlist = Watchlist()
        ..watchId = movieId
        ..type = 'movie';
      await isarService.addWatchlistToFavorite(watchlist);
      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _isFavorite() async {
    bool response = await isarService.isFavorite(movieId);
    setState(() {
      isFavorite = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    int hours = movie != null ? movie!.runtime! ~/ 60 : 0;
    int minutes = movie != null ? movie!.runtime! % 60 : 0;

    return Scaffold(
        body: movie != null
          ? CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: movie?.backdropPath != null ?
                Image.network(movie!.backdropPath ?? '', fit: BoxFit.cover) :
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
              actions: [
                IconButton(
                  // icon: FutureBuilder<IconData>(
                  //   future: getIcon(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return Icon(snapshot.data!);
                  //     } else {
                  //       return const Icon(Icons.favorite_border);
                  //     }
                  //   },
                  // ),
                  icon: isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                  onPressed: () => updateWatchList(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black26),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Image.network(movie.posterPath),
                    Text(movie!.title ?? ''),
                    Text(movie!.genres!.map((genre) => genre.name).join(', ')),
                    Text(movie!.releaseDate ?? ''),
                    Text('${movie!.voteAverage?.toStringAsFixed(1).toString()} / 10'),
                    Text('${(movie!.voteAverage! / 2).toStringAsFixed(1).toString()} / 5'),
                    StarRating(rating: movie!.voteAverage! / 2),
                    Text('${movie!.voteCount?.floor().toString()} votes'),
                    Text('$hours h $minutes min'),
                    Text(movie!.status ?? ''),
                    Text(movie!.originalLanguage ?? ''),
                    Text(movie!.originCountries!.join(', ')),
                    Text(movie!.overview ?? ''),
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