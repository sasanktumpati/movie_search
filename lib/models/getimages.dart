import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Images {
  late String title;
  late String poster;
  late String fanart;

  Images({
    required this.title,
    required this.poster,
    required this.fanart,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      title: json['title'],
      poster: json["poster"],
      fanart: json["fanart"],
    );
  }
}

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://movies-tv-shows-database.p.rapidapi.com/',
    headers: {
      'Type': 'get-movies-images-by-imdb',
      'X-RapidAPI-Key': '9fcf40d969msh383854ae2619dfep1bd892jsn8f5fa3bb1907',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    },
  ));
});

final imagesApiClientProvider = Provider<ImagesAPIclient>((ref) {
  final dio = ref.watch(dioProvider);
  return ImagesAPIclient(dio);
});

class ImagesAPIclient {
  final Dio _dio;

  ImagesAPIclient(this._dio);

  Future<Images> getImages(String movieId) async {
    try {
      final response = await _dio.get('', queryParameters: {'movieId': movieId});
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        print(responseData);
        return Images.fromJson(responseData);
      } else {
        throw Exception('Failed to load Images');
      }
    } catch (e) {
      throw Exception('Failed to load Images: $e');
    }
  }
}
