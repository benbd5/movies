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
    final existingTvShow = await isar.tvShows.get(tvShow.id);

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

  Future<void> deleteTvShow(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.tvShows.delete(id);
    });
  }

  Future<void> saveMovie(Movie movie) async {
    final isar = await db;
    final existingMovie = await isar.movies.get(movie.id);

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

  Future<void> deleteMovie(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.movies.delete(id);
    });
  }

  Future<bool> isFavorite(int id, TypeEnum type) async {
    final isar = await db;

    if (type == TypeEnum.movie) {
      final movie = await isar.movies.filter().tmdbIdEqualTo(id);
      return movie != null;
    } else {
      final tvShow = await isar.tvShows.filter().tmdbIdEqualTo(id);
      return tvShow != null;
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

  Stream<bool> watchFavoriteStatus(int id, TypeEnum type) async* {
    final isar = await db;
    if (type == TypeEnum.movie) {
      yield* isar.movies.watchObject(id).map((movie) => movie != null);
    } else {
      yield* isar.tvShows.watchObject(id).map((tvShow) => tvShow != null);
    }
  }
}
