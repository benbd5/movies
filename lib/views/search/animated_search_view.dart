import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_app/enum/type_enum.dart';
import 'package:movies_app/models/search_movies_list.dart';
import 'package:movies_app/models/tv_show_list.dart';
import 'package:movies_app/utils/tmdb_api/movie_api.dart';
import 'package:movies_app/utils/tmdb_api/tv_show_api.dart';

class AnimatedSearchView extends StatefulWidget {
  final BuildContext parentContext;
  final TypeEnum searchType;

  const AnimatedSearchView({
    super.key,
    required this.parentContext,
    required this.searchType,
  });

  @override
  _AnimatedSearchViewState createState() => _AnimatedSearchViewState();

  static void show(BuildContext context, TypeEnum searchType) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return AnimatedSearchView(parentContext: context, searchType: searchType);
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
  List<dynamic> _searchResults = [];
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
        _performSearch(_textController.text);
      } else {
        setState(() {
          _searchResults = [];
        });
      }
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
    });
    try {
      switch (widget.searchType) {
        case TypeEnum.movie:
          _searchResults = await MovieApi.searchMovies(query);
          break;
        case TypeEnum.tvShow:
          _searchResults = await TvShowApi.searchTvShows(query);
          break;
      }
      setState(() {
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
          if (_searchResults.isEmpty && !_isLoading) {
            Navigator.of(context).pop();
          }
        },
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.black.withOpacity(0.8),
              title: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                controller: _textController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: widget.searchType == TypeEnum.movie ? 'Search movies...' : 'Search TV shows...',
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
                onSubmitted: (value) => _performSearch(value),
              ),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                    setState(() {
                      _searchResults = [];
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
                  return _buildListTile(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(dynamic item) {
    String title, releaseDate, overview;
    String? posterPath;
    int id;

    if (item is SearchList) {
      title = item.title ?? 'No title';
      releaseDate = item.releaseDate != null ? item.releaseDate!.substring(0, 4) : 'No release date';
      overview = item.overview ?? 'No overview';
      posterPath = item.posterPath;
      id = item.id;
    } else if (item is TvShowList) {
      title = item.title ?? 'No title';
      releaseDate = item.firstAirDate != null ? item.firstAirDate!.substring(0, 4) : 'No release date';
      overview = item.overview ?? 'No overview';
      posterPath = item.posterPath;
      id = item.id;
    } else {
      return const SizedBox();
    }

    return ListTile(
      leading: posterPath != null
          ? Image.network(posterPath, width: 50, fit: BoxFit.cover)
          : const Icon(Icons.movie),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(releaseDate, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(overview, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          widget.searchType == TypeEnum.movie ? '/movie_details' : '/tv_show_details',
          arguments: id,
        );
      },
    );
  }
}
