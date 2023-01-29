import 'package:movie_app/classes/movie.dart';

class PopularMoviesResponse {
  int? currentPage;
  List<Movie>? popularMoviesList;
  int? totalPages;
  int? totalResults;
  String? error;

  PopularMoviesResponse({
    required this.currentPage,
    required this.popularMoviesList,
    required this.totalPages,
    required this.totalResults,
  });

  PopularMoviesResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['page'];
    if (json['results'] != null) {
      popularMoviesList = [];
      json['results'].forEach((popularMovie) {
        popularMoviesList!.add(Movie.fromJson(popularMovie));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  PopularMoviesResponse.withError(String errorMessage) {
    error = errorMessage;
  }
}
