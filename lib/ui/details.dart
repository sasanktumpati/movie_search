import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_search/logic/star_rating.dart';

import '../logic/yt_launcher.dart';
import '../models/byid.dart';
import '../models/getimages.dart';
import '../services/moviesprovider.dart';

class DetailsPage extends ConsumerWidget {
  final String? imdbId;

  const DetailsPage({Key? key, required this.imdbId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    if (kDebugMode) {
      print('\n height : ${height} \n');
    }

    final AsyncValue<MoviesById> movieDetails =
        ref.watch(getMoviesByIDProvider(imdbId!));
    final AsyncValue<MovieImages> images = ref.watch(ImagesProvider(imdbId!));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: height * 0.04,
          ),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.lighten,
            color: Colors.white70,
          ),
          child: movieDetails.when(
            data: (data) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  CarouselSlider(
                    items: [
                      images.when(
                        data: (data) => Image.network(
                          data.poster != null
                              ? data.poster!
                              : 'https://i.ibb.co/hXDHWc4/4.jpg"',
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
                              : 'https://i.ibb.co/hXDHWc4/4.jpg"',
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                data.title != null
                                    ? data.title!
                                    : "Not Available",
                                style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                openTrailer('${data.youtubeTrailerKey}');
                              },
                              tooltip: "Play Trailer",
                              icon: const Icon(Icons.play_circle_fill,
                                  size: 60, color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          data.tagline != null
                              ? data.tagline!
                              : "Tagline not Available",
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data.description != null
                              ? data.description!
                              : "Not Available",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        data.rated != null
                            ? Center(
                                child: StarRatingWidget(
                                    imdbRating: double.parse(data.imdbRating!)),
                              )
                            : Text(
                                "Rating: Not Available",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          data.rated != null
                              ? "Age Rating: ${data.rated!}"
                              : "Age Rating: Not Available",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Release Date: ${formatter.format(data.releaseDate)}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   final String imdbID = ; // Provide the IMDb ID here;
//   runApp(
//     const ProviderScope(
//       child: DetailsPage(imdbID: imdbID),
//     ),
//   );
// }
