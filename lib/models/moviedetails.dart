import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'byid.dart';
import 'bytitle.dart';
import 'getimages.dart';
import 'nowplaying.dart';

class MovieProvider {
  static Future<MovieImage> getMovieImages(String movieId) async {
    var headers = {
      'Type': 'get-movies-images-by-imdb',
      'X-RapidAPI-Key': '95f22c543bmsh3ded0bb854a345cp17f572jsn87b22fa04bb9',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    };

    var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/', {'movieid': movieId});

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print('Movie images response: $responseData');
      return MovieImage.fromJson(responseData);
    } else {
      throw Exception('Failed to load movie images');
    }
  }

  static Future<NowPlayingMovies?> getNowPlayingMovies() async {
    var headers = {
      'Type': 'get-nowplaying-movies',
      'X-RapidAPI-Key': '95f22c543bmsh3ded0bb854a345cp17f572jsn87b22fa04bb9',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    };

    var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/', {'page': '1'});

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print('Now playing movies response: $responseData');
      return NowPlayingMovies.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch now playing movies');
    }
  }

  static Future<MovieByTitle?> getMoviesByTitle(String inputText) async {
    var headers = {
      'Type': 'get-movies-by-title',
      'X-RapidAPI-Key': '95f22c543bmsh3ded0bb854a345cp17f572jsn87b22fa04bb9',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    };

    var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/', {'title': inputText});

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print('Movies by title response: $responseData');
      return MovieByTitle.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch movies by title');
    }
  }

  static Future<MovieById?> getMoviesByID(String imdbID) async {
    var headers = {
      'Type': 'get-movie-details',
      'X-RapidAPI-Key': '95f22c543bmsh3ded0bb854a345cp17f572jsn87b22fa04bb9',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    };

    var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/', {'movieid': imdbID});

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print('Movie details response: $responseData');
      return MovieById.fromJson(responseData);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}

class MovieRepository {
  final String movieTitle;

  MovieRepository({required this.movieTitle});

  Future<MovieByTitle?> fetchMoviesData() async {
    var headers = {
      'Type': 'get-movies-by-title',
      'X-RapidAPI-Key': '95f22c543bmsh3ded0bb854a345cp17f572jsn87b22fa04bb9',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    };

    var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/', {'title': movieTitle});

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
