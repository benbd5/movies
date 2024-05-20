import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:movies_app/utils/isar_service.dart';
import 'package:movies_app/views/widgets/bottom_navigation_bar.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  final IsarService isarService = IsarService();
  late IsarCollection<Watchlist>? watchlist;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(selectedIndex: 1),
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: FutureBuilder(
        future: isarService.getAllWatchlists(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].watchIds.toString()),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}