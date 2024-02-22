import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/bytitle.dart';
import '../models/nowplaying.dart';
import 'moviecard.dart';

class HomeListView extends StatefulWidget {
  @override
  _HomeListViewState createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                });
              },
            )
                : null,
          ),
          onChanged: (value) {
            setState(() {});
          },
        )
            : Text(
          'Now Playing',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: _isSearching ? _buildSearchResults() : _buildNowPlayingMovies(),
    );
  }

  Widget _buildSearchResults() {
    final String query = _searchController.text.trim();
    return Consumer(
      builder: (context, ref, child) => FutureBuilder<MovieSearchResponse>(
        future: ref.watch(movieSearchApiClientProvider).searchMoviesByTitle(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final results = snapshot.data!.movieResults;
            return GridView.builder(
              itemCount: results.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MovieCard(movieId: results[index].imdbId),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildNowPlayingMovies() {
    return Consumer(
      builder: (context, ref, child) => FutureBuilder<NowPlayingResponse>(
        future: ref.watch(nowPlayingApiClientProvider).getNowPlayingMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final results = snapshot.data!.movieResults;
            return GridView.builder(
              itemCount: results.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MovieCard(movieId: results[index].imdbId),
                );
              },
            );
          }
        },
      ),
    );
  }
}
