import 'package:flutter/material.dart';
import 'package:movie_search/ui/searchbox.dart';
import 'moviecard.dart';

class HomeListView extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
      ),
      body: Column(
        children: [
          SearchBox(
            controller: searchController,
            onChanged: (value) {
              // Handle search query changes here
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Just for demonstration
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MovieCard(
                    title: 'Movie Title',
                    imageUrl: 'https://via.placeholder.com/150',
                    imdbRating: 7.5, // Example IMDb rating
                    youtubeTrailerKey: 'your_trailer_key', // Example trailer key
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
