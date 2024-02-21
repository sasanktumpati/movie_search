import 'package:dio/dio.dart';

class MovieResult {
  late String title;
  late int year;
  late String imdbId;
  late int search_results;


  MovieResult.fromJson(Map<String, dynamic> json) {
    title = int.parse(json['title']) as String;
    year = json['year'];
    imdbId = json['imdb_id'];
    search_results = json['search_results'];

  }
}

class MovieSearchResponse {
  late List<MovieResult> movieResults;
  late int searchResults;

  MovieSearchResponse.fromJson(Map<String, dynamic> json) {
    movieResults = (json['movie_results'] as List)
        .map((result) => MovieResult.fromJson(result))
        .toList();
    searchResults = json['search_results'];

  }
}

class MovieSearchApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://movies-tv-shows-database.p.rapidapi.com/',
    headers: {
      'Type': 'get-movies-by-title',
      'X-RapidAPI-Key': '991a1779demshbb49135bb161b12p1c24b7jsn50d6ba889c63',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    },
  )
  );

  Future<MovieSearchResponse> searchMoviesByTitle(String title) async {
    try {
      final response = await _dio.get('', queryParameters: {'title': title});
      if (response.statusCode == 200) {
        return MovieSearchResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to search movies by title');
      }
    } catch (e) {
      throw Exception('Failed to search movies by title: $e');
    }
  }
}
