import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/like.dart';
import '../logic/star_rating.dart';
import '../logic/yt_launcher.dart';
import '../models/byid.dart';

final movieDetailsProvider = FutureProvider.autoDispose.family<Movie, String>((ref, movieId) {
  return ref.watch(movieApiClientProvider).getMovieDetails(movieId);
});

class MovieCard extends ConsumerWidget {
  final String movieId;

  MovieCard({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetails = ref.watch(movieDetailsProvider(movieId));

    return movieDetails.when(
      data: (movie) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white.withOpacity(0.8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              movie.year.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 8),
                            StarRatingWidget(imdbRating: movie.imdbRating),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        LikeButton(),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => openTrailer(movie.youtubeTrailerKey),
                          child: Text('Watch Trailer'),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to movie details page
                          },
                          child: Text('See Details'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (err, stack) {
        return Center(
          child: Text('Error: ${err.toString()}'),
        );
      },
    );
  }
}