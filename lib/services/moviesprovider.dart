import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/byid.dart';
import '../models/bytitle.dart';
import '../models/getimages.dart';
import '../models/nowplaying.dart';

final ImagesProvider =
    FutureProvider.family<MovieImages, String>((ref, movieId) async {
  var headers = {
    'Type': 'get-movies-images-by-imdb',
    'X-RapidAPI-Key': '642ff82731mshb9284b2cfc87479p1aeeadjsn077ad2578941',
    'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };

  var uri = Uri.https(
      'movies-tv-shows-database.p.rapidapi.com', '/', {'movieid': movieId});

  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    if (kDebugMode) {
      print('Movie images response: $responseData');
    }
    return MovieImages.fromJson(responseData);
  } else {
    throw Exception('Failed to load images');
  }
});

final nowPlayingProvider = FutureProvider<NowPlayingMovies>((ref) async {
  var headers = {
    'Type': 'get-nowplaying-movies',
    'X-RapidAPI-Key': '642ff82731mshb9284b2cfc87479p1aeeadjsn077ad2578941',
    'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };

  var uri =
      Uri.https('movies-tv-shows-database.p.rapidapi.com', '/', {'page': '1'});

  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    print('Now playing movies response: $responseData');
    return NowPlayingMovies.fromJson(responseData);
  } else {
    throw Exception('Failed to fetch now playing movies');
  }
});

final getMoviesByNameProvider =
    FutureProvider.family<MoviesByTitle, String>((ref, inputText) async {
  var headers = {
    'Type': 'get-movies-by-title',
    'X-RapidAPI-Key': '642ff82731mshb9284b2cfc87479p1aeeadjsn077ad2578941',
    'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };

  var uri = Uri.https(
      'movies-tv-shows-database.p.rapidapi.com', '/', {'title': inputText});

  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    print('Movies by title response: $responseData');
    return MoviesByTitle.fromJson(responseData);
  } else {
    throw Exception('Failed to fetch movies by title');
  }
});

final SelectionProvider = StateProvider((ref) => "");

final getMoviesByIDProvider =
    FutureProvider.family<MoviesById, String>((ref, imdbID) async {
  var headers = {
    'Type': 'get-movie-details',
    'X-RapidAPI-Key': '642ff82731mshb9284b2cfc87479p1aeeadjsn077ad2578941',
    'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };

  var uri = Uri.https(
      'movies-tv-shows-database.p.rapidapi.com', '/', {'movieid': imdbID});

  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    print('Movie details response: $responseData');
    return MoviesById.fromJson(responseData);
  } else {
    throw Exception('Failed to load movie details');
  }
});

class Repo {
  final String movieTitle;

  Repo({required this.movieTitle});

  Future<ByTitleResults> fetchMoviesData() async {
    var headers = {
      'Type': 'get-movies-by-title',
      'X-RapidAPI-Key': '642ff82731mshb9284b2cfc87479p1aeeadjsn077ad2578941',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    };

    var uri = Uri.https(
        'movies-tv-shows-database.p.rapidapi.com', '/', {'title': movieTitle});

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print('Fetch movies data response: $responseData');
      return ByTitleResults.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch movies by title');
    }
  }
}

final showDescriptionProvider = StateProvider<bool>((ref) => true);

final searchQuery = StateProvider((ref) => "");

final searchQueryProvider =
    StateNotifierProvider<SearchQueryNotifier, String>((ref) {
  return SearchQueryNotifier();
});

class SearchQueryNotifier extends StateNotifier<String> {
  SearchQueryNotifier() : super('');

  void update(String newValue) => state = newValue;
}
