import 'package:flutter/material.dart';
import 'package:movie_search/ui/searchbox.dart';
import 'package:provider/provider.dart';

import '../models/bytitle.dart';
import '../models/nowplaying.dart';
import 'moviecard.dart';

class HomeListView extends StatefulWidget {
  @override
  _HomeListViewState createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie App',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SearchBox(),
          Expanded(
            child: Consumer<HomeListProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return provider.searchedMovies.isEmpty
                      ? _buildNowPlayingList(provider.nowPlayingMovies)
                      : _buildSearchedList(provider.searchedMovies);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNowPlayingList(List<NowPlaying> nowPlayingMovies) {
    return ListView.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlayingMovies[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: MovieCard(movie: movie),
        );
      },
    );
  }

  Widget _buildSearchedList(List<MovieResult> searchedMovies) {
    return ListView.builder(
      itemCount: searchedMovies.length,
      itemBuilder: (context, index) {
        final movie = searchedMovies[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: MovieCard(movie: movie),
        );
      },
    );
  }
}
