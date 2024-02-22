import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class MovieImage {
  late String title;
  late String poster;
  late String fanart;

  MovieImage({
    required this.title,
    required this.poster,
    required this.fanart,
  });

  factory MovieImage.fromJson(Map<String, dynamic> json) {
    return MovieImage(
      title: json['title'] ?? '', // Handle null value
      poster: json['poster'] ?? '', // Handle null value
      fanart: json['fanart'] ?? '', // Handle null value
    );
  }
}

final movieImagesProvider = FutureProvider.family<MovieImage, String>((ref, movieId) async {
  try {
    var headers = {
      'Type': 'get-movies-images-by-imdb',
      'X-RapidAPI-Key': '95f22c543bmsh3ded0bb854a345cp17f572jsn87b22fa04bb9',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    };

    var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/', {'movieid': movieId});

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData != null) {
        return MovieImage.fromJson(responseData);
      } else {
        throw Exception('Response data is null');
      }
    } else {
      throw Exception('Failed to load Images. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load Images: $e');
  }
});
