// import 'package:flutter/material.dart';
// import 'byid.dart';
//
// class MovieDetailsPage extends StatefulWidget {
//   final String movieId;
//
//   MovieDetailsPage({required this.movieId});
//
//   @override
//   _MovieDetailsPageState createState() => _MovieDetailsPageState();
// }
//
// class _MovieDetailsPageState extends State<MovieDetailsPage> {
//   late Future<Movie> _movieDetails;
//
//   @override
//   void initState() {
//     super.initState();
//     _movieDetails = _fetchMovieDetails();
//   }
//
//   Future<Movie> _fetchMovieDetails() async {
//     try {
//       // Fetch movie details using movieId
//       Movie movie = await MovieApiClient().getMovieDetails(widget.movieId);
//       return movie;
//     } catch (e) {
//       throw Exception('Failed to fetch movie details: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Movie Details'),
//       ),
//       body: FutureBuilder<Movie>(
//         future: _movieDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             Movie movie = snapshot.data!;
//             return _buildMovieDetails(movie);
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildMovieDetails(Movie movie) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             movie.title,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text('Year: ${movie.year.toString()}'),
//           SizedBox(height: 8),
//           Text('Description: ${movie.description}'),
//           SizedBox(height: 8),
//           Text('Tagline: ${movie.tagline}'),
//           SizedBox(height: 8),
//           Text('IMDb Rating: ${movie.imdbRating.toString()}'),
//           SizedBox(height: 8),
//           Text('Rated: ${movie.rated}'),
//           // Add more details as needed
//         ],
//       ),
//     );
//   }
// }
