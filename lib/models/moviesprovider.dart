import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'byid.dart';
import 'bytitle.dart';
import 'getimages.dart';
import 'nowplaying.dart';

final ImagesProvider =
FutureProvider.family<MovieImages, String>((ref, movieId) async {
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
    return MovieImages.fromJson(responseData);
  } else {
    throw Exception('Failed to load images');
  }
});



final nowPlayingProvider = FutureProvider<NowPlayingMovies>((ref) async {
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
    return NowPlayingMovies.fromJson(responseData);
  } else {
    throw Exception('Failed to fetch now playing movies');
  }
});

final getMoviesByNameProvider =
FutureProvider.family<Moviesbytitle, String>((ref, inputText) async {
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
    return Moviesbytitle.fromJson(responseData);
  } else {
    throw Exception('Failed to fetch movies by title');
  }
});

final SelectionProvider = StateProvider((ref) => "");

final getMoviesByIDProvider =
FutureProvider.family<MoviesById, String>((ref, imdbID) async {
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
    return MoviesById.fromJson(responseData);
  } else {
    throw Exception('Failed to load movie details');
  }
});

class Repo {
  final String movieTitle;

  Repo({required this.movieTitle});

  Future<Moviesbytitle> fetchMoviesData() async {
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
      return Moviesbytitle.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch movies by title');
    }
  }
}

final searchQuery = StateProvider((ref) => "");
