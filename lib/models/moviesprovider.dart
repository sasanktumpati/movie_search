import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'byid.dart';
import 'bytitle.dart';
import 'getimages.dart';
import 'nowplaying.dart';

final movieImagesProvider =
FutureProvider.family<MovieImage, String>((ref, movieId) async {
  var headers = {
    'Type': 'get-movies-images-by-imdb',
    'X-RapidAPI-Key': 'bb72b850f0msh562c04851d0f1a1p1a0ebcjsn813c727955e4',
    'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };

  var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/',
      {'movieid': movieId});

  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    print('Movie images response: $responseData');
    return MovieImage.fromJson(responseData);
  } else {
    throw Exception('Failed to load movie images');
  }
});



final nowMoviesProvider = FutureProvider<NowPlayingMovie>((ref) async {
  var headers = {
    'Type': 'get-nowplaying-movies',
    'X-RapidAPI-Key': 'bb72b850f0msh562c04851d0f1a1p1a0ebcjsn813c727955e4',
    'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };

  var uri = Uri.https(
      'movies-tv-shows-database.p.rapidapi.com', '/', {'page': '1'});

  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    print('Now playing movies response: $responseData');
    return NowPlayingMovie.fromJson(responseData);
  } else {
    throw Exception('Failed to fetch now playing movies');
  }
});

final getMoviesByNameProvider =
FutureProvider.family<MovieByTitle, String>((ref, inputText) async {
  var headers = {
    'Type': 'get-movies-by-title',
    'X-RapidAPI-Key': 'bb72b850f0msh562c04851d0f1a1p1a0ebcjsn813c727955e4',
    'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };

  var uri = Uri.https(
      'movies-tv-shows-database.p.rapidapi.com', '/', {'title': inputText});

  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    print('Movies by title response: $responseData');
    return MovieByTitle.fromJson(responseData);
  } else {
    throw Exception('Failed to fetch movies by title');
  }
});

final movieSelectedProvider = StateProvider((ref) => "");

final getMoviesByIDProvider =
FutureProvider.family<MovieById, String>((ref, imdbID) async {
  var headers = {
    'Type': 'get-movie-details',
    'X-RapidAPI-Key': 'bb72b850f0msh562c04851d0f1a1p1a0ebcjsn813c727955e4',
    'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
  };

  var uri = Uri.https(
      'movies-tv-shows-database.p.rapidapi.com', '/', {'movieid': imdbID});

  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    print('Movie details response: $responseData');
    return MovieById.fromJson(responseData);
  } else {
    throw Exception('Failed to load movie details');
  }
});

class MovieRepository {
  final String movieTitle;

  MovieRepository({required this.movieTitle});

  Future<MovieByTitle> fetchMoviesData() async {
    var headers = {
      'Type': 'get-movies-by-title',
      'X-RapidAPI-Key': 'bb72b850f0msh562c04851d0f1a1p1a0ebcjsn813c727955e4',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    };

    var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/',
        {'title': movieTitle});

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print('Fetch movies data response: $responseData');
      return MovieByTitle.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch movies by title');
    }
  }
}

final searchInputTextProvider = StateProvider((ref) => "");
