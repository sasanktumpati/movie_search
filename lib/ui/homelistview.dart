import 'package:flutter/material.dart';
import 'package:movie_search/models/nowplaying.dart';

class MovieCard extends StatelessWidget {
  final NowPlaying movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        leading: Image.network(
          movie.poster,
          width: 100,
          height: 150,
          fit: BoxFit.cover,
        ),
        title: Text(
          movie.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Release Year: ${movie.year}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        onTap: () {
          // Navigate to movie details page
          // You can implement this based on your navigation setup
        },
      ),
    );
  }
}
