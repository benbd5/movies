import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:yeez/enum/type_enum.dart';
import 'package:yeez/models/movie_list.dart';
import 'package:yeez/views/movies/carousel_movies.dart';
import 'package:yeez/views/movies/detail.dart';
import 'package:yeez/views/movies/list.dart';
import 'package:yeez/views/profile/watchlist.dart';
import 'package:yeez/views/search/animated_search_view.dart';
import 'package:yeez/views/tv_shows.dart';
import 'package:yeez/views/tv_shows/detail.dart';
import 'package:yeez/views/widgets/bottom_navigation_bar.dart';
import 'package:yeez/views/widgets/shimmer_carousel_loader.dart';
import 'package:yeez/views/widgets/shimmer_loader.dart';
import 'utils/tmdb_api/movie_api.dart';
import 'models/genre.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  await Isar.initializeIsarCore();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          background: Colors.black26,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black26,
          titleTextStyle: TextStyle(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.all(10),
          titleTextStyle: TextStyle(color: Colors.white),
          subtitleTextStyle: TextStyle(color: Colors.white38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enableFeedback: true,
          tileColor: Colors.black12,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black87,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const HomePage(),
      routes: {
        '/movies': (context) => const HomePage(),
        '/tv_shows': (context) => const TvShows(),
        '/watchlist': (context) => const Watchlist(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/movie_details') {
          return MaterialPageRoute(
            builder: (context) => MovieDetail(movieId: settings.arguments as int),
          );
        }
        if (settings.name == '/tv_show_details') {
          return MaterialPageRoute(
            builder: (context) => TvShowDetail(tvShowId: settings.arguments as int),
          );
        }
        return null;
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MoviesState();
}

class _MoviesState extends State<HomePage> {
  late List<MovieList> popularMovies = [];
  late List<MovieList> discoverMovies = [];
  late List<MovieList> nowPlayingMovies = [];
  late List<Genre> genres = [];
  int selectedMonths = 1;

  @override
  void initState() {
    super.initState();
    getPopularMovies();
    getUpcomingMovies();
    getNowPlayingMovies();
    getGenres();
  }

  Future<void> getGenres() async {
    try {
      final List<Genre> getGenres = await MovieApi.getGenres();
      setState(() {
        genres = getGenres;
      });
    } catch (e) {}
  }

  Future<void> getPopularMovies() async {
    try {
      final List<MovieList> getMovies = await MovieApi.getPopularMovies();
      setState(() {
        popularMovies = getMovies;
      });
    } catch (e) {}
  }

  Future<void> getUpcomingMovies() async {
    try {
      final List<MovieList> getMovies = await MovieApi.getDiscoverMovies(selectedMonths);
      setState(() {
        discoverMovies = getMovies;
      });
    } catch (e) {}
  }

  Future<void> getNowPlayingMovies() async {
    try {
      final List<MovieList> getMovies = await MovieApi.getNowPlayingMovies();
      setState(() {
        nowPlayingMovies = getMovies;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      bottomNavigationBar: const BottomNavigation(selectedIndex: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            popularMovies.isEmpty ? const ShimmerCarouselLoader() : CarouselMovies(movies: popularMovies),
            Row(
              children: [
               const Align(
                alignment: Alignment.centerLeft,
                child: Text('Upcoming Movies', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                const SizedBox(width: 16),
                DropdownButton<int>(
                  dropdownColor: Colors.black87,
                  value: selectedMonths,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('1 Month')),
                    DropdownMenuItem(value: 3, child: Text('3 Months')),
                    DropdownMenuItem(value: 6, child: Text('6 Months')),
                    DropdownMenuItem(value: 12, child: Text('12 Months')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedMonths = value!;
                      getUpcomingMovies();
                    });
                  },
                ),
              ],
            ),
            discoverMovies.isEmpty ? const ShimmerLoader() : MoviesList(movies: discoverMovies),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Movies currently in theatres'),
            ),
            nowPlayingMovies.isEmpty ? const ShimmerLoader() : MoviesList(movies: nowPlayingMovies),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AnimatedSearchView.show(context, TypeEnum.movie);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
