import 'dart:convert';

Moviesbytitle movieByTitleFromJson(String str) =>
    Moviesbytitle.fromJson(json.decode(str));

class Moviesbytitle {
  final List<bytitleResults>? movieResults;
  final int? searchResults;
  final String status;
  final String statusMessage;

  Moviesbytitle({
    required this.movieResults,
    required this.searchResults,
    required this.status,
    required this.statusMessage,
  });

  factory Moviesbytitle.fromJson(Map<String, dynamic> json) => Moviesbytitle(
    movieResults: List<bytitleResults>.from(
        json["movie_results"].map((x) => bytitleResults.fromJson(x))),
    searchResults: json["search_results"],
    status: json["status"],
    statusMessage: json["status_message"],
  );
}

class bytitleResults {
  final String? title;
  final int? year;
  final String? imdbId;

  bytitleResults({
    required this.title,
    required this.year,
    required this.imdbId,
  });

  factory bytitleResults.fromJson(Map<String, dynamic> json) => bytitleResults(
    title: json["title"],
    year: json["year"],
    imdbId: json["imdb_id"],
  );
}
