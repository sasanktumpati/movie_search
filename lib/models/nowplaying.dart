import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowPlaying {
  late String title;
  late int year;
  late String imdbId;
  late int results;

  NowPlaying({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.results,
  });

  factory NowPlaying.fromJson(Map<String, dynamic> json) {
    return NowPlaying(
      title: json['title'],
      year: int.parse(json['year']),
      imdbId: json['imdb_id'],
      results: int.parse(json['results']),
    );
  }
}

class NowPlayingResponse {
  late List<NowPlaying> movieResults;
  late String totalResults;
  late String status;
  late String statusMessage;

  NowPlayingResponse({
    required this.movieResults,
    required this.totalResults,
    required this.status,
    required this.statusMessage,
  });

  factory NowPlayingResponse.fromJson(Map<String, dynamic> json) {
    List<NowPlaying> results = (json['movie_results'] as List)
        .map((result) => NowPlaying.fromJson(result))
        .toList();
    return NowPlayingResponse(
      movieResults: results,
      totalResults: json['Total_results'],
      status: json['status'],
      statusMessage: json['status_message'],
    );
  }
}

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://movies-tv-shows-database.p.rapidapi.com/',
    headers: {
      'Type': 'get-nowplaying-movies',
      'X-RapidAPI-Key': '9fcf40d969msh383854ae2619dfep1bd892jsn8f5fa3bb1907',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    },
  ));
});

final nowPlayingApiClientProvider = Provider<NowPlayingApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return NowPlayingApiClient(dio);
});

class NowPlayingApiClient {
  final Dio _dio;

  NowPlayingApiClient(this._dio);

  Future<NowPlayingResponse> getNowPlayingMovies() async {
    try {
      final response = await _dio.get('');
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        print(responseData); // Print response data
        return NowPlayingResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to fetch now playing movies');
      }
    } catch (e) {
      throw Exception('Failed to fetch now playing movies: $e');
    }
  }
}
