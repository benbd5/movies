import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/models/movie_list.dart';
import 'package:movies_app/views/movies/popular.dart';
import './utils/tmdb_api.dart';
import './models/movie.dart';
import 'models/genre.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MoviesState();
}

class _MoviesState extends State<HomePage> {
  late List<MovieList> movies = [];
  late List<Genre> genres = [];

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
    fetchGenres();
  }

  Future<void> fetchGenres() async {
    try {
      final List<Genre> fetchedGenres = await MovieService.fetchGenres();
      setState(() {
        genres = fetchedGenres;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchPopularMovies() async {
    try {
      final List<MovieList> fetchedMovies = await MovieService.fetchPopularMovies();
      setState(() {
        movies = fetchedMovies;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: [
          PopularMovies(movies: movies),
        ],
      ),
    );
  }
}
