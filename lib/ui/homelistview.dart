import 'package:flutter/material.dart';
import '../models/moviedetails.dart';
import '../models/nowplaying.dart';
import 'moviecard.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: _buildNowPlayingMovies(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNowPlayingMovies() {
    return FutureBuilder<NowPlayingMovies?>(
      future: MovieProvider.getNowPlayingMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null) {
          return Center(child: Text('No Data'));
        } else {
          final movies = snapshot.data!.movies;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: MovieCard(movieId: movies[index].imdbId),
              );
            },
          );
        }
      },
    );
  }
}
