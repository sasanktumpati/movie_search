import 'package:dio/dio.dart';

class Images {
  late String title;
  late String poster;
  late String fanart;


  Images.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    poster = json["poster"];
    fanart = json["fanart"];

  }

}

class ImagesAPIclient {
  final Dio imageurls = Dio(BaseOptions(
    baseUrl: 'https://movies-tv-shows-database.p.rapidapi.com/',
    headers: {
      'Type': 'get-movies-images-by-imdb',
      'X-RapidAPI-Key': '991a1779demshbb49135bb161b12p1c24b7jsn50d6ba889c63',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    },

  ));

  Future<Images> getImages(String movieId) async {
    try {
      final response = await imageurls.get(
          '', queryParameters: {'movieId': movieId});
      if (response.statusCode == 200) {
        return Images.fromJson(response.data);
      } else {
        throw Exception('Failed to load Images');
      }
    } catch (e) {
      throw Exception('Failed to load Images: $e');
    }
  }
}
