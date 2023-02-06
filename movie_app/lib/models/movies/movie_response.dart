import 'package:movie_app/models/genres/genre.dart';
import 'package:movie_app/models/movies/movie.dart';

//Class to store information from API response
//Creates instances of Movie class and stores them to a list
//It also has properties used for filter functionality

class MovieResponse {
  int? currentPage;
  List<Movie>? moviesList;
  int? totalPages;
  int? totalResults;

  List<Genre>? allGenresList = [];
  List<Movie>? searchResultsList = [];
  List<int>? chosenGenresList = [];
  int? chosenYear;
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
