import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({super.key, this.rating = 0});

  @override
  Widget build(BuildContext context) {
    final wholeStars = rating.floor();
    final fractionalStar = rating - wholeStars;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index < wholeStars) {
          return const Icon(Icons.star, color: Colors.yellow);
        } else if (index == wholeStars && fractionalStar > 0) {
          return const Icon(Icons.star_half, color: Colors.yellow);
        }
        else {
          return const Icon(Icons.star_border, color: Colors.yellow);
        }
      }),
    );
  }
}
