import 'dart:ffi';

import 'package:dio/dio.dart';

class Movie {
  late String title;
  late String description;
  late String tagline;
  late double year;
  late String releaseDate;
  late String imdbId;
  late double imdbRating;
  late double voteCount;
  late double popularity;
  late String youtubeTrailerKey;
  late String rated;


  Movie.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    tagline = json['tagline'];
    year = double.parse(json['year']);
    releaseDate = json['release_date'];
    imdbId = json['imdb_id'];
    imdbRating = double.parse(json['imdb_rating']);
    voteCount = double.parse(json['vote_count']);
    popularity = double.parse(json['popularity']);
    youtubeTrailerKey = json['youtube_trailer_key'];
    rated = json['rated'];
  }
}

class MovieApiClient {
  final Dio databyid = Dio(BaseOptions(
    baseUrl: 'https://movies-tv-shows-database.p.rapidapi.com/',
    headers: {
      'Type': 'get-movie-details',
      'X-RapidAPI-Key': '991a1779demshbb49135bb161b12p1c24b7jsn50d6ba889c63',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    },
  ));

  Future<Movie> getMovieDetails(String movieId) async {
    try {
      final response = await databyid.get('', queryParameters: {'movieid': movieId});
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}


