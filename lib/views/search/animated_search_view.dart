import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app/models/search_movies_list.dart';
import 'package:movies_app/utils/tmdb_api/movie_api.dart';

class AnimatedSearchView extends StatefulWidget {
  final BuildContext parentContext;

  const AnimatedSearchView({super.key, required this.parentContext});

  @override
  _AnimatedSearchViewState createState() => _AnimatedSearchViewState();

  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return AnimatedSearchView(parentContext: context);
      },
      transitionBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}

class _AnimatedSearchViewState extends State<AnimatedSearchView> {
  final TextEditingController _textController = TextEditingController();
  List<SearchMovieList> _movies = [];
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onSearchChanged);
    _textController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_textController.text.length > 2) {
        _searchMovies(_textController.text);
      } else {
        setState(() {
          _movies = [];
        });
      }
    });
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.8),
      child: InkWell(
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        enableFeedback: false,
        radius: 0,
        onTap: () {
          if (_movies.isEmpty && !_isLoading) {
            Navigator.of(context).pop();
          }
        },
        child:Column(
        children: [
          AppBar(
            backgroundColor: Colors.black.withOpacity(0.8),
            title: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: _textController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) => _searchMovies(value),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _textController.clear();
                  setState(() {
                    _movies = [];
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _movies.isEmpty
              ? Center(
                child: Text(
                  _textController.text.isEmpty
                    ? 'Enter a search term'
                    : 'No movies found. Tap anywhere to close.',
                  textAlign: TextAlign.center,
                ),
              )
              : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return ListTile(
                  leading: movie.posterPath != null
                    ? Image.network(movie.posterPath!, width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.movie),
                  title: Text(movie.title ?? 'No title'),
                  subtitle: Text(movie.releaseDate ?? 'No release date'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/movie_details',
                      arguments: movie.id,
                    );
                  },
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
