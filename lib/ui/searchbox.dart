import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/ui/details.dart';

import '../services/moviesprovider.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchQuery);
    final moviesList = ref.watch(getMoviesByNameProvider(searchText));

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final backColor = Theme.of(context).colorScheme.background;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        title: TextField(
          autofocus: true,
          onChanged: (value) {
            ref.watch(searchQuery.notifier).update((state) => value);
          },
        ),
      ),
      body: moviesList.when(
        data: (data) {
          if (data.movieResults == null) {
            return const Center(
              child: Text("No Results Found"),
            );
          } else if (searchText.isEmpty) {
            return Center(
              child: Text(
                'Search Movies....',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: height * 0.03,
                ),
              ),
            );
          } else {
            if (kDebugMode) {
              print('hello ${data.movieResults!.length}');
            }

            return ListView.builder(
              itemCount: data.movieResults!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white, // set card color to cream
                  elevation: 1, // add a slight shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // rounded edges
                    side: BorderSide(
                        color: Colors.black, width: 1), // black border
                  ),
                  child: ListTile(
                    title: Text(
                      data.movieResults![index].title ??
                          "", // null check for title
                      style: TextStyle(
                          color: Colors.black), // set text color to black
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            imdbId: data.movieResults![index].imdbId!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
