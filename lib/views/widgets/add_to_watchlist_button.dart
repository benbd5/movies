import 'dart:ui';
import 'package:flutter/material.dart';

class AddToWatchlistButton extends StatelessWidget {
  final bool isFavorite;
  final Function updateWatchList;
  const AddToWatchlistButton({super.key, required this.isFavorite, required this.updateWatchList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: FloatingActionButton(
            onPressed: () {
              updateWatchList();
            },
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
