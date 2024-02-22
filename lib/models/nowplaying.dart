import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'byid.dart';

class NowPlayingMovies {
  late String title;
  late int year; // Assuming year is an integer
  late String imdbId;
  late int results;
  late List<MovieById> movies; // Added movies field

  NowPlayingMovies({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.results,
    required this.movies,
  });

  factory NowPlayingMovies.fromJson(Map<String, dynamic> json) {
    final List<MovieById> moviesList = (json['movies'] as List)
        .map((movieJson) => MovieById.fromJson(movieJson))
        .toList();
    return NowPlayingMovies(
      title: json['title'] ?? '',
      year: int.parse(json['year'] ?? '0'),
      imdbId: json['imdb_id'] ?? '',
      results: int.parse(json['results'] ?? '0'),
      movies: moviesList,
    );
  }
}

final nowMoviesProvider = FutureProvider<NowPlayingMovies>((ref) async {
  try {
    var headers = {
      'Type': 'get-nowplaying-movies',
      'X-RapidAPI-Key': '95f22c543bmsh3ded0bb854a345cp17f572jsn87b22fa04bb9',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    };

    var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/', {'page': '1'});

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData != null) {
        return NowPlayingMovies.fromJson(responseData);
      } else {
        throw Exception('Response data is null');
      }
    } else {
      throw Exception('Failed to fetch now playing movies. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch now playing movies: $e');
  }
});
