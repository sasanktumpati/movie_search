import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search/logic/star_rating.dart';

import '../logic/yt_launcher.dart';
import '../models/byid.dart';
import '../models/getimages.dart';
import '../models/moviesprovider.dart';

class MovieDetails extends ConsumerWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String imdbID = ref.watch(movieSelectedProvider);
    final AsyncValue<MovieById> movieDetails =
    ref.watch(getMoviesByIDProvider(imdbID));
    final AsyncValue<MovieImage> images =
    ref.watch(movieImagesProvider(imdbID));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          color: Colors.white70,
        ),
        child: movieDetails.when(
          data: (data) {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CarouselSlider(
                      items: [
                        images.when(
                          data: (data) => Image.network(
                            data.poster != null
                                ? data.poster!
                                : 'https://www.indieactivity.com/wp-content/uploads/2022/03/File-Not-Found-Poster.png',
                            gaplessPlayback: true,
                          ),
                          error: (error, stackTrace) =>
                              Center(child: Text('Error: $error')),
                          loading: () =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        images.when(
                          data: (d) => Image.network(
                            d.fanart != null
                                ? d.fanart!
                                : 'https://www.indieactivity.com/wp-content/uploads/2022/03/File-Not-Found-Poster.png',
                            gaplessPlayback: true,
                          ),
                          error: (error, stackTrace) =>
                              Center(child: Text('Error: $error')),
                          loading: () =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        pageSnapping: true,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.2,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openTrailer(data.youtubeTrailerKey!);
                      },
                      tooltip: "Play Trailer",
                      icon: const Icon(
                        Icons.local_movies_outlined,
                        size: 80,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title != null ? data.title! : "Not Available",
                          style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          data.tagline != null
                              ? data.tagline!
                              : "TagLine not Available",
                          style: TextStyle(color: Colors.red),
                        ),
                        data.rated != null
                            ? Center(
                          child: StarRatingWidget(
                            imdbRating: double.parse(data.imdbRating!),
                          ),
                        )
                            : const Text(
                          "Not Available",
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          data.description != null
                              ? data.description!
                              : "Not Available",
                          style: TextStyle(color: Colors.black54),
                        ),
                        Text(
                          data.rated != null
                              ? "Age Rating: ${data.rated!}"
                              : "Not Available",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Release Date: ${formatter.format(data.releaseDate)}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
          error: (error, stackTrace) =>
              Center(child: Text('Error: $error')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
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
      child: MovieDetails(),
    ),
  );
}