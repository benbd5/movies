import 'package:flutter/material.dart';
import 'package:movies_app/views/movies/popular.dart';
import './utils/tmdb_api.dart';
import './models/movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _MoviesState();
}

class _MoviesState extends State<HomePage> {
  late List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
  }

  Future<void> fetchPopularMovies() async {
    try {
      final List<Movie> fetchedMovies = await MovieService.fetchPopularMovies();
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
