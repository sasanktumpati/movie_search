import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final double imdbRating;

  StarRatingWidget({required this.imdbRating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            i < (imdbRating / 2).round() ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
      ],
    );
  }
}
