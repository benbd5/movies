import 'package:flutter/material.dart';
import 'package:movies_app/models/search_movies_list.dart';
import 'package:movies_app/utils/tmdb_api/movie_api.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({super.key});

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final TextEditingController _controller = SearchController();
  List _movies = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _searchMovies(String query) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final List<SearchMovieList> searchMovies = await MovieApi.searchMovies(query);

      setState(() {
        _movies = searchMovies;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 300,
      margin: const EdgeInsets.only(top: 10),
      child: SearchBar(
        textInputAction: TextInputAction.search,
        controller: _controller,
        hintText: 'Search for a movie',
        onSubmitted: (query) {
          _searchMovies(query);
        },
        onChanged: (query) {
          if (query.isEmpty) {
            setState(() {
              _movies = [];
            });
          }
          if (query.length > 2) {
            Future.delayed(const Duration(milliseconds: 500), () {
              _searchMovies(query);
            });
          }
        },
      ),
    );
  }
}