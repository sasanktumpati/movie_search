import 'package:flutter/material.dart';
import '../logic/like.dart';
import '../logic/star_rating.dart';
import '../logic/yt_launcher.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double imdbRating;
  final String youtubeTrailerKey;

  const MovieCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.imdbRating,
    required this.youtubeTrailerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          // Handle card tap
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    StarRatingWidget(imdbRating: imdbRating),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        LikeButton(),
                        SizedBox(width: 8.0),
                        TrailerButton(youtubeTrailerKey: youtubeTrailerKey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
