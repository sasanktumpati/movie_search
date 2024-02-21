import 'package:dio/dio.dart';

class MovieResult {
  late String title;
  late int year;
  late String imdbId;
  late int search_results;


  MovieResult.fromJson(Map<String, dynamic> json) {
    title = json['title'].toInt();
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
      'X-RapidAPI-Key': '9fcf40d969msh383854ae2619dfep1bd892jsn8f5fa3bb1907',
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

// void main() async {
//   final MovieSearchApiClient movieSearchApiClient = MovieSearchApiClient();
//
//   try {
//     MovieSearchResponse response =
//     await movieSearchApiClient.searchMoviesByTitle('Harry Potter');
//     print('Search Results: ${response.searchResults}');
//     print('Status: ${response.status}');
//     print('Status Message: ${response.statusMessage}');
//     response.movieResults.forEach((result) {
//       print('Title: ${result.title}, Year: ${result.year}, IMDB ID: ${result.imdbId}');
//     });
//   } catch (e) {
//     print('Error: $e');
//   }
// }
