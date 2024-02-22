import 'package:flutter/material.dart';

import '../logic/like.dart';
import '../logic/star_rating.dart';
import '../logic/yt_launcher.dart';
import '../models/byid.dart';
import '../models/getimages.dart';
import '../models/moviedetails.dart';

class MovieCard extends StatelessWidget {
  final String movieId;

  MovieCard({required this.movieId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<MovieById?>(
      future: MovieProvider.getMoviesByID(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No Data'));
        } else {
          final movie = snapshot.data!;
          return GestureDetector(
            onTap: () => openTrailer(movie.youtubeTrailerKey),
            child: SizedBox(
              width: screenWidth * 0.9, // Set width to 90% of screen width
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // White with a bit of blur
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: FutureBuilder<MovieImage>(
                        future: MovieProvider.getMovieImages(movieId),
                        builder: (context, imageSnapshot) {
                          if (imageSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (imageSnapshot.hasError) {
                            return Center(child: Text('Error: ${imageSnapshot.error}'));
                          } else if (!imageSnapshot.hasData) {
                            return Center(child: Text('No Data'));
                          } else {
                            final image = imageSnapshot.data!;
                            return Image.network(
                              image.poster,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            StarRatingWidget(imdbRating: movie.imdbRating),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                LikeButton(),
                                SizedBox(width: 10.0),
                                ElevatedButton(
                                  onPressed: () {/* Handle See Details */},
                                  child: Text('See Details'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
