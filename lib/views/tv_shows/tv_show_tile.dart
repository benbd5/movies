import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yeez/models/tv_show_list.dart';

class TvShowTile extends StatelessWidget {
  const TvShowTile({
    super.key,
    required this.tvShows,
    required this.context,
  });

  final List<TvShowList> tvShows;
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
            itemCount: tvShows.length,
            itemBuilder: (context, index) {
              Image image = Image(
                image: CachedNetworkImageProvider(tvShows[index].posterPath),
                fit: BoxFit.cover,
              );

              precacheImage(image.image, context);

              return InkWell(onTap: () {
                Navigator.pushNamed(
                  context,
                  '/tv_show_details',
                  arguments: tvShows[index].id,
                );
              },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: tvShows[index].posterPath != '' ?
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