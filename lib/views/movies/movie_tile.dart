import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_list.dart';

import 'detail.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    super.key,
    required this.movies,
    required this.context,
  });

  final List<MovieList> movies;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    MaterialPageRoute(builder: (context) => MovieDetail(movieId: movies[index].id))
                );
              },
                child:
                Container(
                  padding: const EdgeInsets.all(8),
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: movies[index].posterPath != null ?
                    Image.network(movies[index].posterPath!, fit: BoxFit.fill) :
                    Container(
                      color: Colors.grey,
                      width: 150,
                      child: const Icon(Icons.movie, color: Colors.white, size: 50),
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