import 'package:flutter/material.dart';
import 'package:movie_search/ui/searchbox.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/bytitle.dart';
import '../models/nowplaying.dart';
import 'moviecard.dart';

class HomeListView extends StatefulWidget {
  @override
  _HomeListViewState createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  final TextEditingController _searchController = TextEditingController();
  List<MovieCard> _movieCards = [];

  @override
  void initState() {
    super.initState();
    _fetchNowPlayingMovies();
  }

  void _fetchNowPlayingMovies() async {
    try {
      final nowPlayingResponse = await NowPlayingApiClient().getNowPlayingMovies();
      setState(() {
        _movieCards = nowPlayingResponse.movieResults
            .map((movie) => MovieCard(
          title: movie.title,
          imageUrl: '', // You can use the getImages API here to get the image URL
          onPressed: () => _navigateToDetailsPage(movie.imdbId),
        ))
            .toList();
      });
    } catch (e) {
      print('Error fetching now playing movies: $e');
    }
  }

  void _searchMovies(String title) async {
    try {
      final searchResponse = await MovieSearchApiClient().searchMoviesByTitle(title);
      setState(() {
        _movieCards = searchResponse.movieResults
            .map((movie) => MovieCard(
          title: movie.title,
          imageUrl: '', // You can use the getImages API here to get the image URL
          onPressed: () => _navigateToDetailsPage(movie.imdbId),
        ))
            .toList();
      });
    } catch (e) {
      print('Error searching movies: $e');
    }
  }

  void _navigateToDetailsPage(String imdbId) {
    // Implement navigation using GoRouter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: Column(
        children: [
          SearchBox(
            controller: _searchController,
            onChanged: _searchMovies,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _movieCards.length,
              itemBuilder: (context, index) => _movieCards[index],
            ),
          ),
        ],
      ),
    );
  }
}
