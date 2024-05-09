import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_list.dart';
import 'package:movies_app/views/movies/detail.dart';
import 'package:movies_app/models/movie.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class PopularMovies extends StatelessWidget {
  final List<MovieList> movies;
  const PopularMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Popular Movies'),
        ),
        SizedBox(
          height: 200,
          child:
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return InkWell(onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MovieDetail(movieId: movies[index].id)
                    ),
                  );
                },
                child:
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        movies[index].posterPath,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            ),
        ),
      ],
    );
  }
}
