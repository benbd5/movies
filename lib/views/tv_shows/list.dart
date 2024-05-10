import 'package:flutter/material.dart';
import 'package:movies_app/models/tv_show_list.dart';
import 'package:movies_app/views/tv_shows/detail.dart';

class TvShowsList extends StatelessWidget {
  final List<TvShowList> tvShows;
  const TvShowsList({super.key, required this.tvShows});

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
              return InkWell(onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TvShowDetail(tvShowId: tvShows[index].id))
                );
              },
                child:
                Container(
                  padding: const EdgeInsets.all(8),
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: tvShows[index].posterPath != null ?
                    Image.network(tvShows[index].posterPath!, fit: BoxFit.fill) :
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