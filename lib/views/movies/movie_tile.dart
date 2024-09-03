import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yeez/models/movie_list.dart';

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
              Image image = Image(
                image: CachedNetworkImageProvider(movies[index].posterPath),
                fit: BoxFit.cover,
              );

              precacheImage(image.image, context);

              return InkWell(onTap: () {
                Navigator.pushNamed(
                  context,
                  '/movie_details',
                  arguments: movies[index].id,
                );
              },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: movies[index].posterPath != '' ?
                    image :
                    Container(
                      color: Colors.grey.withOpacity(0.25),
                      width: 150,
                      child: Icon(Icons.movie, color: Colors.white.withOpacity(0.9), size: 50),
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