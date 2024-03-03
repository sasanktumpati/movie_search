import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search/logic/like.dart';
import 'package:movie_search/ui/details.dart';
import 'package:movie_search/ui/searchbox.dart';

import '../services/moviesprovider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nowPlayingMovies = ref.watch(nowPlayingProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: null,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: const SearchBox(),
      ),
      body: nowPlayingMovies.when(
        data: (data) {
          final movie = data.movieResults;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Now Playing",
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  physics: const PageScrollPhysics(),
                  cacheExtent: 800,
                  itemCount: movie.length,
                  itemBuilder: (context, index) {
                    final String movieId = movie[index].imdbId;

                    final movieImage = ref.watch(ImagesProvider(movieId));

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(imdbId: movie[index].imdbId)),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: movieImage.when(
                                    data: (data) {
                                      return Image.network(
                                        data.poster != null
                                            ? data.poster!
                                            : 'https://i.ibb.co/S794thq/2.jpg',
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.network(
                                            'https://i.ibb.co/S794thq/2.jpg',
                                            gaplessPlayback: true,
                                          );
                                        },
                                        gaplessPlayback: true,
                                        colorBlendMode: BlendMode.darken,
                                      );
                                    },
                                    error: (error, stackTrace) =>
                                        Center(child: Text('Error: $error')),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  movie[index].title,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      movie[index].year,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.left,
                                    ),
                                    LikeButton(imdbId: movie[index].imdbId),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 16 / 9,
                    crossAxisCount: 2,
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(
            child: Text(
          'Error: $error',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    const ProviderScope(
      child: HomeScreen(),
    ),
  );
}

class SearchBox extends ConsumerWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        autofocus: false,
        onChanged: (value) {
          ref.watch(searchQuery.notifier).update((state) => value);
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.search),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          hintText: "Search Movies...",
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
          border: InputBorder.none,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        },
      ),
    );
  }
}
