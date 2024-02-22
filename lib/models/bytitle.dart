import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieResult {
  late String title;
  late int year;
  late String imdbId;
  late String poster;
  late String youtubeTrailerKey;
  late double imdbRating;

  MovieResult({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.poster,
    required this.youtubeTrailerKey,
    required this.imdbRating,
  });

  factory MovieResult.fromJson(Map<String, dynamic> json) {
    return MovieResult(
      title: json['title'],
      year: json['year'],
      imdbId: json['imdb_id'],
      poster: json['poster'],
      youtubeTrailerKey: json['youtubeTrailerKey'],
      imdbRating: json['imdbRating'],
    );
  }
}

class MovieSearchResponse {
  late List<MovieResult> movieResults;
  late int searchResults;

  MovieSearchResponse({
    required this.movieResults,
    required this.searchResults,
  });

  factory MovieSearchResponse.fromJson(Map<String, dynamic> json) {
    List<MovieResult> results = (json['movie_results'] as List)
        .map((result) => MovieResult.fromJson(result))
        .toList();
    return MovieSearchResponse(
      movieResults: results,
      searchResults: json['search_results'],
    );
  }
}

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://movies-tv-shows-database.p.rapidapi.com/',
    headers: {
      'Type': 'get-movies-by-title',
      'X-RapidAPI-Key': '9fcf40d969msh383854ae2619dfep1bd892jsn8f5fa3bb1907',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    },
  ));
});

final movieSearchApiClientProvider = Provider<MovieSearchApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return MovieSearchApiClient(dio);
});

class MovieSearchApiClient {
  final Dio _dio;

  MovieSearchApiClient(this._dio);

  Future<MovieSearchResponse> searchMoviesByTitle(String title) async {
    try {
      final response = await _fetchMoviesByTitle(title);
      if (response.statusCode == 200) {
        print(response.data);
        return MovieSearchResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to search movies by title');
      }
    } catch (e) {
      throw Exception('Failed to search movies by title: $e');
    }
  }

  Future<Response<dynamic>> _fetchMoviesByTitle(String title) async {
    final Map<String, dynamic> options = {
      'method': 'GET',
      'url': 'https://movies-tv-shows-database.p.rapidapi.com/',
      'params': {'title': title},
    };
    try {
      final response = await _dio.request(
        options['url'],
        queryParameters: options['params'],
        options: Options(
          method: options['method'],
          headers: {
            'Type': 'get-movies-by-title',
            'X-RapidAPI-Key': '9fcf40d969msh383854ae2619dfep1bd892jsn8f5fa3bb1907',
            'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
          },
        ),
      );
      return response;
    } catch (error) {
      throw Exception('Failed to fetch movies by title: $error');
    }
  }
}
