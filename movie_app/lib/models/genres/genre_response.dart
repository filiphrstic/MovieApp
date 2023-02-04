import 'package:movie_app/models/genres/genre.dart';

//Creates a list of genres based on API response with Genre class

class GenreResponse {
  List<Genre>? genresList;
  String? error;

  GenreResponse.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genresList = [];
      json['genres'].forEach((genre) {
        genresList!.add(Genre.fromJson(genre));
      });
    }
  }

  GenreResponse.withError(String errorMessage) {
    error = errorMessage;
  }
}
