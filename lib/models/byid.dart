import 'dart:convert';
import 'package:intl/intl.dart';

MovieById movieByIdFromJson(String str) => MovieById.fromJson(json.decode(str));

final formatter = DateFormat.yMd();

class MovieById {
  final String? title;
  final String? description;
  final String? tagline;
  final String? year;
  final DateTime releaseDate;
  final String? imdbId;
  final String? imdbRating;
  final String? youtubeTrailerKey;
  final String? rated;
  final String status;
  final String statusMessage;

  MovieById({
    required this.title,
    required this.description,
    required this.tagline,
    required this.year,
    required this.releaseDate,
    required this.imdbId,
    required this.imdbRating,
    required this.youtubeTrailerKey,
    required this.rated,
    required this.status,
    required this.statusMessage,
  });

  factory MovieById.fromJson(Map<String, dynamic> json) => MovieById(
    title: json["title"],
    description: json["description"],
    tagline: json["tagline"],
    year: json["year"],
    releaseDate: DateTime.parse(json["release_date"]),
    imdbId: json["imdb_id"],
    imdbRating: json["imdb_rating"],
    youtubeTrailerKey: json["youtube_trailer_key"],
    rated: json["rated"],
    status: json["status"],
    statusMessage: json["status_message"],
  );

  String get formattedDate {
    return formatter.format(releaseDate);
  }
}




// import 'dart:convert';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
//
// class MovieById {
//   late String title;
//   late String description;
//   late String tagline;
//   late double year;
//   late String releaseDate;
//   late String imdbId;
//   late double imdbRating;
//   late double voteCount;
//   late double popularity;
//   late String youtubeTrailerKey;
//   late String rated;
//
//   MovieById({
//     required this.title,
//     required this.description,
//     required this.tagline,
//     required this.year,
//     required this.releaseDate,
//     required this.imdbId,
//     required this.imdbRating,
//     required this.voteCount,
//     required this.popularity,
//     required this.youtubeTrailerKey,
//     required this.rated,
//   });
//
//   factory MovieById.fromJson(Map<String, dynamic> json) {
//     return MovieById(
//       title: json['title'],
//       description: json['description'],
//       tagline: json['tagline'],
//       year: double.parse(json['year']),
//       releaseDate: json['release_date'],
//       imdbId: json['imdb_id'],
//       imdbRating: double.parse(json['imdb_rating']),
//       voteCount: double.parse(json['vote_count']),
//       popularity: double.parse(json['popularity']),
//       youtubeTrailerKey: json['youtube_trailer_key'],
//       rated: json['rated'],
//     );
//   }
// }
//
// final getMoviesByIDProvider = FutureProvider.family<MovieById, String>((ref, imdbID) async {
//   try {
//     var headers = {
//       'Type': 'get-movie-details',
//       'X-RapidAPI-Key': '95f22c543bmsh3ded0bb854a345cp17f572jsn87b22fa04bb9',
//       'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
//     };
//
//     var uri = Uri.https('movies-tv-shows-database.p.rapidapi.com', '/', {'movieid': imdbID});
//
//     var response = await http.get(uri, headers: headers);
//
//     if (response.statusCode == 200) {
//       var responseData = jsonDecode(response.body);
//       if (responseData != null) {
//         return MovieById.fromJson(responseData);
//       } else {
//         throw Exception('Response data is null');
//       }
//     } else {
//       throw Exception('Failed to load movie details. Status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Failed to load movie details: $e');
//   }
// });
//
//
//
//
// // import "dart:convert";
// //
// // import "package:dio/dio.dart";
// // import "package:flutter_riverpod/flutter_riverpod.dart";
// //
// // class Movie {
// //   late String title;
// //   late String description;
// //   late String tagline;
// //   late double year;
// //   late String releaseDate;
// //   late String imdbId;
// //   late double imdbRating;
// //   late double voteCount;
// //   late double popularity;
// //   late String youtubeTrailerKey;
// //   late String rated;
// //
// //   Movie({
// //     required this.title,
// //     required this.description,
// //     required this.tagline,
// //     required this.year,
// //     required this.releaseDate,
// //     required this.imdbId,
// //     required this.imdbRating,
// //     required this.voteCount,
// //     required this.popularity,
// //     required this.youtubeTrailerKey,
// //     required this.rated,
// //   });
// //
// //   factory Movie.fromJson(Map<String, dynamic> json) {
// //     return Movie(
// //       title: json["title"],
// //       description: json["description"],
// //       tagline: json["tagline"],
// //       year: double.parse(json["year"]),
// //       releaseDate: json["release_date"],
// //       imdbId: json["imdb_id"],
// //       imdbRating: double.parse(json["imdb_rating"]),
// //       voteCount: double.parse(json["vote_count"]),
// //       popularity: double.parse(json["popularity"]),
// //       youtubeTrailerKey: json["youtube_trailer_key"],
// //       rated: json["rated"],
// //     );
// //   }
// // }
// //
// // final dioProvider = Provider<Dio>((ref) {
// //   return Dio(BaseOptions(
// //     baseUrl: "https://movies-tv-shows-database.p.rapidapi.com/",
// //     headers: {
// //       "Type": "get-movie-details",
// //       "X-RapidAPI-Key": "9fcf40d969msh383854ae2619dfep1bd892jsn8f5fa3bb1907",
// //       "X-RapidAPI-Host": "movies-tv-shows-database.p.rapidapi.com",
// //     },
// //   ));
// // });
// //
// // final movieApiClientProvider = Provider<MovieApiClient>((ref) {
// //   final dio = ref.watch(dioProvider);
// //   return MovieApiClient(dio);
// // });
// //
// // class MovieApiClient {
// //   final Dio _dio;
// //
// //   MovieApiClient(this._dio);
// //
// //   Future<Movie> getMovieDetails(String movieId) async {
// //     try {
// //       final response = await _dio.get("", queryParameters: {"movieid": movieId});
// //       if (response.statusCode == 200) {
// //         final responseData = json.decode(response.data);
// //         print(responseData);
// //         return Movie.fromJson(responseData);
// //       } else {
// //         throw Exception("Failed to load movie details");
// //       }
// //     } catch (e) {
// //       throw Exception("Failed to load movie details: $e");
// //     }
// //   }
// // }
