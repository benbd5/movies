import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:movies_app/enum/type_enum.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/tv_show.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveTvShow(TvShow tvShow) async {
    final isar = await db;
    final existingTvShow = await isar.tvShows.get(tvShow.tmdbId);

    if (existingTvShow != null) {
      return;
    }
    isar.writeTxnSync(() => isar.tvShows.putSync(tvShow));
  }

  Future<List<TvShow>> getAllTvShows() async {
    final isar = await db;
    return await isar.tvShows.where().findAll();
  }

  Future<TvShow?> getTvShowById(int id) async {
    final isar = await db;
    return await isar.tvShows.get(id);
  }

  Future<void> deleteTvShow(int tmdbId) async {
    final isar = await db;
    await isar.writeTxn(() => isar.tvShows.filter().tmdbIdEqualTo(tmdbId).deleteFirst());
  }

  Future<void> saveMovie(Movie movie) async {
    final isar = await db;
    final existingMovie = await isar.movies.get(movie.tmdbId);

    if (existingMovie != null) {
      return;
    }
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  Future<List<Movie>> getAllMovies() async {
    final isar = await db;
    return await isar.movies.where().findAll();
  }

  Future<Movie?> getMovieById(int id) async {
    final isar = await db;
    return await isar.movies.get(id);
  }

  Future<void> deleteMovie(int tmdbId) async {
    final isar = await db;
    await isar.writeTxn(() => isar.movies.filter().tmdbIdEqualTo(tmdbId).deleteFirst());
  }

  Future<bool> isFavorite(int tmdbId, TypeEnum type) async {
    final isar = await db;
    if (type == TypeEnum.movie) {
      return await isar.movies.filter().tmdbIdEqualTo(tmdbId).isNotEmpty();
    } else {
      return await isar.tvShows.filter().tmdbIdEqualTo(tmdbId).isNotEmpty();
    }
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [MovieSchema, TvShowSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
