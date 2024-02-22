import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Movie({
    required this.title,
    required this.description,
    required this.tagline,
    required this.year,
    required this.releaseDate,
    required this.imdbId,
    required this.imdbRating,
    required this.voteCount,
    required this.popularity,
    required this.youtubeTrailerKey,
    required this.rated,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      description: json['description'],
      tagline: json['tagline'],
      year: double.parse(json['year']),
      releaseDate: json['release_date'],
      imdbId: json['imdb_id'],
      imdbRating: double.parse(json['imdb_rating']),
      voteCount: double.parse(json['vote_count']),
      popularity: double.parse(json['popularity']),
      youtubeTrailerKey: json['youtube_trailer_key'],
      rated: json['rated'],
    );
  }

}

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://movies-tv-shows-database.p.rapidapi.com/',
    headers: {
      'Type': 'get-movie-details',
      'X-RapidAPI-Key': '9fcf40d969msh383854ae2619dfep1bd892jsn8f5fa3bb1907',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    },
  ));
});

final movieApiClientProvider = Provider<MovieApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return MovieApiClient(dio);
});

class MovieApiClient {
  final Dio _dio;

  MovieApiClient(this._dio);

  Future<Movie> getMovieDetails(String movieId) async {
    try {
      final response = await _dio.get('', queryParameters: {'movieid': movieId});
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        print(responseData);
        return Movie.fromJson(responseData);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}