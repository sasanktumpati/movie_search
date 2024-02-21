import 'package:dio/dio.dart';

class Movie {
  late String title;
  late String description;
  late String tagline;
  late double year;
  late String releaseDate;
  late String imdbId;
  late double imdbRating;
  late double voteCount;
  late double popularity;
  late String youtubeTrailerKey;
  late String rated;


  Movie.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    tagline = json['tagline'];
    year = json['year'].toDouble();
    releaseDate = json['release_date'];
    imdbId = json['imdb_id'];
    imdbRating = json['imdb_rating'].toDouble();
    voteCount = json['vote_count'].toDouble();
    popularity = json['popularity'].toDouble();
    youtubeTrailerKey = json['youtube_trailer_key'];
    rated = json['rated'];
  }
}

class MovieApiClient {
  final Dio databyid = Dio(BaseOptions(
    baseUrl: 'https://movies-tv-shows-database.p.rapidapi.com/',
    headers: {
      'Type': 'get-movie-details',
      'X-RapidAPI-Key': '9fcf40d969msh383854ae2619dfep1bd892jsn8f5fa3bb1907',
      'X-RapidAPI-Host': 'movies-tv-shows-database.p.rapidapi.com',
    },
  ));

  Future<Movie> getMovieDetails(String movieId) async {
    try {
      final response = await databyid.get('', queryParameters: {'movieid': movieId});
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}


