import 'package:isar/isar.dart';

part 'watchlist.g.dart';

@collection
class Watchlist {
  Id id = Isar.autoIncrement;
  late String type;
  late int watchId;
}