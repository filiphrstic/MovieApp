import 'package:movie_app/classes/movie.dart';

//Class to store information from API response
//It also creates instances of Movie class and stores them to a list

class MovieResponse {
  int? currentPage;
  List<Movie>? moviesList;
  int? totalPages;
  int? totalResults;
  String? error;

  MovieResponse({
    required this.currentPage,
    required this.moviesList,
    required this.totalPages,
    required this.totalResults,
  });

  MovieResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['page'];
    if (json['results'] != null) {
      moviesList = [];
      json['results'].forEach((popularMovie) {
        moviesList!.add(Movie.fromJson(popularMovie));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  MovieResponse.withError(String errorMessage) {
    error = errorMessage;
  }
}
