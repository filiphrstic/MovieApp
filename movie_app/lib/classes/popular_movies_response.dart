import 'package:movie_app/classes/movie.dart';

class PopularMoviesResponse {
  late int currentPage;
  late List<Movie> popularMoviesList;
  late int totalPages;
  late int totalResults;

  PopularMoviesResponse({
    required this.currentPage,
    required this.popularMoviesList,
    required this.totalPages,
    required this.totalResults,
  });

  PopularMoviesResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['page'];
    popularMoviesList = [];
    json['results'].foreach((popularMovie) {
      popularMoviesList.add(Movie.fromJson(popularMovie));
    });
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}
