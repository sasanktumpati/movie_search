import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

NowPlayingMovies nowPlayingMovieFromJson(String str) =>
    NowPlayingMovies.fromJson(json.decode(str));

class NowPlayingMovies {
  final List<MoviesResult> movieResults;
  final int results;
  final String totalResults;
  final String status;
  final String statusMessage;

  NowPlayingMovies({
    required this.movieResults,
    required this.results,
    required this.totalResults,
    required this.status,
    required this.statusMessage,
  });

  factory NowPlayingMovies.fromJson(Map<String, dynamic> json) =>
      NowPlayingMovies(
        movieResults: List<MoviesResult>.from(
            json["movie_results"].map((x) => MoviesResult.fromJson(x))),
        results: json["results"],
        totalResults: json["Total_results"],
        status: json["status"],
        statusMessage: json["status_message"],
      );
}

class MoviesResult {
  final String title;
  final String year;
  final String imdbId;
  final likeStateProvider = StateProvider((ref) => false);

  MoviesResult({
    required this.title,
    required this.year,
    required this.imdbId,
  });

  factory MoviesResult.fromJson(Map<String, dynamic> json) => MoviesResult(
    title: json["title"],
    year: json["year"],
    imdbId: json["imdb_id"],
  );
}