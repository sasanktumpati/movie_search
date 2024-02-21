import 'package:dio/dio.dart';

class NowPlaying {
  late String title;
  late int year;
  late String imdbId;
  late int results;

  NowPlaying.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    year = int.parse(json['year']);
    imdbId = json['imdb_id'];
    results = int.parse(json['results']);

  }
}

class NowPlayingResponse {
  late List<NowPlaying> movieResults;
  late String totalResults;
  late String status;
  late String statusMessage;

  NowPlayingResponse.fromJson(Map<String, dynamic> json) {
    movieResults = (json['movie_results'] as List)
        .map((result) => NowPlaying.fromJson(result))
        .toList();
    totalResults = json['Total_results'];
    status = json['status'];
    statusMessage = json['status_message'];
  }
}

class NowPlayingApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://movies-tv-shows-database.p.rapidapi.com/',
    headers: {
      'Type': 'get-nowplaying-movies',
      'X-RapidAPI-Key': '991a1779demshbb49135bb161b12p1c24b7jsn50d6ba889c63',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    },
  ));

  Future<NowPlayingResponse> getNowPlayingMovies() async {
    try {
      final response = await _dio.get('');
      if (response.statusCode == 200) {
        return NowPlayingResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch now playing movies');
      }
    } catch (e) {
      throw Exception('Failed to fetch now playing movies: $e');
    }
  }
}
