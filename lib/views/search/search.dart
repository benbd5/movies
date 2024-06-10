import 'package:flutter/material.dart';
import 'package:movies_app/models/search_movies_list.dart';
import 'package:movies_app/utils/tmdb_api/movie_api.dart';
import 'package:movies_app/views/widgets/bottom_navigation_bar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
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
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(selectedIndex: 3),
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchBar(
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
              },
            ),
            _isLoading
                ? const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return ListTile(
                    title: Text(movie.title ?? 'No title'),
                    subtitle: Text(movie.releaseDate ?? 'No overview'),
                    leading: movie.posterPath == null
                        ? const SizedBox(
                      width: 80,
                      height: 80,
                      child: Icon(Icons.movie),
                    )
                        : Image.network(movie.posterPath!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}