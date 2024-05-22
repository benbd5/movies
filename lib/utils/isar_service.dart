import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:movies_app/database/watchlist.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> addWatchlistToFavorite(Watchlist newWatchlist) async {
    final isar = await db;
    final watchlist = await isar.watchlists
        .filter()
        .typeEqualTo('movie')
        .watchIdEqualTo(newWatchlist.watchId)
        .findFirst();
    if (watchlist == null) {
      await isar.writeTxn(() => isar.watchlists.put(newWatchlist));
    } else {
      await deleteWatchlist(watchlist);
    }
  }

  Future<void> deleteWatchlist(Watchlist watchlist) async {
    final isar = await db;
    await isar.writeTxn(() => isar.watchlists.delete(watchlist.id));
  }

  Future<List<Watchlist>> getAllWatchlists() async {
    final isar = await db;
    final watchlists = await isar.watchlists.where().findAll();
    return watchlists;
  }

  Future<bool> isFavorite(int watchId) async {
    final isar = await db;
    final watchlist = await isar.watchlists
        .filter()
        .typeEqualTo('movie')
        .watchIdEqualTo(watchId)
        .findFirst();
    return watchlist != null;
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
        [WatchlistSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
