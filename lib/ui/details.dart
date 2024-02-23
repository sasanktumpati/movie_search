import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search/logic/star_rating.dart';
import 'package:movie_search/models/byid.dart';
import 'package:movie_search/models/getimages.dart';
import 'package:movie_search/logic/yt_launcher.dart';
import 'package:movie_search/models/moviesprovider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.imdbID}) : super(key: key);

  final String imdbID;

  @override
  Widget build(BuildContext context) {
    
    final movieDetails = getMoviesByIDProvider(imdbID).future;
    final images = ImagesProvider(imdbID).future;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.lighten,
          color: Colors.white70,
        ),
        child: FutureBuilder(
          future: Future.wait<List<Future<dynamic>>>([movieDetails, images]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final data = snapshot.data![0] as MoviesById;
              final image = snapshot.data![1] as MovieImages;

              return Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CarouselSlider(
                        items: [
                          Image.network(
                            image.poster ?? 'https://i.ibb.co/S794thq/2.jpg',
                            gaplessPlayback: true,
                          ),
                          Image.network(
                            image.fanart ?? 'https://i.ibb.co/S794thq/2.jpg',
                            gaplessPlayback: true,
                          ),
                        ],
                        options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          pageSnapping: true,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          openTrailer(data.youtubeTrailerKey!);
                        },
                        tooltip: "Play Trailer",
                        icon: const Icon(
                          Icons.play_circle_fill,
                          size: 80,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: FractionallySizedBox(
                      heightFactor: 1,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title ?? "Not Available",
                              style: GoogleFonts.poppins(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              data.tagline ?? "Tagline not Available",
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                            data.rated != null
                                ? StarRatingWidget(
                              imdbRating: double.parse(data.imdbRating!),
                            )
                                : const Text(
                              "Not Available",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.description ?? "Not Available",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      data.rated != null
                                          ? "Age Rating: ${data.rated!}"
                                          : "Not Available",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
    title: 'Your App Title',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    onGenerateRoute: (settings) {
      if (settings.name == '/details') {
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (context) => DetailsPage(imdbID: args['imdbID']!),
        );
      }
    },
  ));
}
