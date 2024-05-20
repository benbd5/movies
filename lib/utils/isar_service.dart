import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:movies_app/database/watchlist.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveWatchlist(Watchlist newWatchlist) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.watchlists.putSync(newWatchlist));
  }

  Future<List<Watchlist>> getAllWatchlists() async {
    final isar = await db;
    final watchlists = await isar.watchlists.where().findAll();
    return watchlists;
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }


  Future<Isar> openDB() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      final existingIsar = Isar.getInstance();
      if (existingIsar != null) {
        return existingIsar;
      }

      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [WatchlistSchema],
        inspector: true,
        directory: dir.path,
      );
    } catch (e) {
      print('Error opening database: $e');
      rethrow;
    }
  }
}
