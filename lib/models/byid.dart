import 'dart:convert';
import 'package:intl/intl.dart';


class MoviesById {
  final String? title;
  final String? description;
  final String? tagline;
  final String? year;
  final DateTime releaseDate;
  final String? imdbId;
  final String? imdbRating;
  final dynamic youtubeTrailerKey;
  final String? rated;
  final String status;
  final String statusMessage;

  MoviesById({
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

  factory MoviesById.fromJson(Map<String, dynamic> json) => MoviesById(
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


MoviesById movieByIdFromJson(String str) => MoviesById.fromJson(json.decode(str));

final formatter = DateFormat.yMd();




