import 'package:flutter/material.dart';
import '../../models/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context),
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all(Colors.black26),
        //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //         RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(20.0),
        //         )
        //       ),
        //     ),
        //   ),
        //   iconTheme: const IconThemeData(
        //     color: Colors.white,
        //   ),
        // ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(movie.posterPath, fit: BoxFit.cover),
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
                    // Image.network(movie.posterPath),
                    Text(movie.title),
                    Text(movie.genres.join(', ')),
                    Text(movie.releaseDate),
                    Text('${movie.voteAverage.toStringAsFixed(1).toString()} / 10'),
                    Text('${movie.voteCount.floor().toString()} votes'),
                    Text(movie.overview),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}