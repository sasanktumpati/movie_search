import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/moviesprovider.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: ProviderScope(
        child: SearchScreen(),
      ),
    );
  }
}

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final searchText = ref.watch(searchQuery);
    final moviesList = ref.watch(getMoviesByNameProvider(searchText));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ctx.pop();
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: SearchBox(),
      ),
      body: moviesList.when(
        data: (data) {
          if (data.movieResults == null) {
            return const Center(
              child: Text("No Results Found Try Something else.."),
            );
          } else if (searchText.isEmpty) {
            return Container();
          } else {
            return ListView.builder(
              itemCount: data.movieResults!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    data.movieResults![index].title != null
                        ? data.movieResults![index].title!
                        : "",
                  ),
                  onTap: () {
                    context.push("/details");
                    ref.watch(SelectionProvider.notifier).update(
                          (state) => data.movieResults![index].imdbId!,
                    );
                  },
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
