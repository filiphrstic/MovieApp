import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movies/movie_response.dart';
import 'package:movie_app/models/movies/movie.dart';
import 'package:movie_app/providers/file_handler.dart';
import 'package:movie_app/providers/tmdb_provider.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitialState()) {
    final TmdbProvider tmdbProvider = TmdbProvider();

    //Fetching list of popular movies from API and sending back the response
    on<GetPopularMoviesList>((event, emit) async {
      try {
        emit(MovieLoadingState());
        final response = await tmdbProvider.fetchPopularMovies(1);
        emit(MovieLoadedState(response));
        if (response.error != null) {
          emit(MoviesError(response.error));
        }
      } on NetworkError {
        emit(const MoviesError(
            "Unable to fetch data. Please check your internet connection!"));
      }
    });

    /*
    Fetches next page of popular movies when user scrolls to the bottom of the list.
    After receiving the response, it rearanges list of all popular movies so it 
    is being displayed in the right order 
    */
    on<GetMorePopularMoviesList>((event, emit) async {
      try {
        // emit(MovieLoadingState());
        final response =
            await tmdbProvider.fetchPopularMovies(event.previousPage + 1);
        List<Movie> previouslyFetchedMovies = event.previouslyFetchedMovies;
        List<Movie> newlyFetchedMovies = response.moviesList!;
        previouslyFetchedMovies.addAll(newlyFetchedMovies);
        response.moviesList = previouslyFetchedMovies;
        emit(MovieLoadedState(response));
        if (response.error != null) {
          emit(MoviesError(response.error));
        }
      } on NetworkError {
        emit(const MoviesError(
            "Unable to fetch data. Please check your internet connection!"));
      }
    });

    //Fetches list of popular movies from local storage using FileHandler
    on<GetFavoriteMoviesList>((event, emit) async {
      try {
        emit(MovieLoadingState());
        List<Movie> response = [];
        response = await FileHandler.instance
            .readFavoriteMovies()
            .then((value) => response = value);
        emit(FavoriteMoviesLoadedState(response));
      } on Error {
        emit(const MoviesError("Unable to fetch data. Please try again!"));
      }
    });

    //Fetches list of movies that match users search input using appropriate method from TmbdProvider
    on<GetSearchResultsMovieList>((event, emit) async {
      try {
        emit(MovieLoadingState());
        final responseGenres = await tmdbProvider.fetchGenres();
        final responseSearchResults =
            await tmdbProvider.fetchSearchResults(event.query);
        responseSearchResults.allGenresList = responseGenres.genresList;
        responseSearchResults.searchResultsList =
            responseSearchResults.moviesList;
        emit(MovieLoadedState(responseSearchResults));
      } on Error {
        emit(const MoviesError(
            "Unable to fetch data. Please check your internet connection!"));
      }
    });

    //Filters out movie results via genre and release year
    on<FilterChosenEvent>((event, emit) async {
      try {
        emit(MovieLoadingState());
        List<Movie> filteredMovieListByGenre = [];
        List<Movie> filteredMovieListByYear = [];
        List<Movie> initialResultsWithoutFilter =
            event.searchResultsResponse.searchResultsList!;
        int? year = event.chosenYear;
        List<int> genres = event.chosenGenreIDs;

        if (year == null && genres.isEmpty) {
          event.searchResultsResponse.moviesList = initialResultsWithoutFilter;
        } else if (year == null && genres.isNotEmpty) {
          event.searchResultsResponse.chosenGenresList = genres;
          for (var movie in event.searchResultsResponse.searchResultsList!) {
            if (event.chosenGenreIDs.every((chosenGenreID) =>
                movie.genresIdList.contains(chosenGenreID))) {
              filteredMovieListByGenre.add(movie);
            }
          }
          event.searchResultsResponse.moviesList = filteredMovieListByGenre;
        } else if (year != null && genres.isEmpty) {
          event.searchResultsResponse.chosenYear = event.chosenYear!;
          for (var movie in event.searchResultsResponse.searchResultsList!) {
            DateTime movieDateTime = DateTime.parse(movie.releaseDate);
            if (event.chosenYear == movieDateTime.year) {
              filteredMovieListByYear.add(movie);
            }
          }
          event.searchResultsResponse.moviesList = filteredMovieListByYear;
        } else if (year != null && genres.isNotEmpty) {
          event.searchResultsResponse.chosenGenresList = genres;
          event.searchResultsResponse.chosenYear = event.chosenYear!;
          for (var movie in event.searchResultsResponse.searchResultsList!) {
            if (event.chosenGenreIDs.every((chosenGenreID) =>
                movie.genresIdList.contains(chosenGenreID))) {
              filteredMovieListByGenre.add(movie);
            }
          }
          for (var movie in event.searchResultsResponse.searchResultsList!) {
            DateTime movieDateTime = DateTime.parse(movie.releaseDate);
            if (event.chosenYear == movieDateTime.year) {
              filteredMovieListByYear.add(movie);
            }
          }
          filteredMovieListByGenre.removeWhere(
              (element) => !filteredMovieListByYear.contains(element));
          event.searchResultsResponse.moviesList = filteredMovieListByGenre;
        }
        emit(MovieLoadedState(event.searchResultsResponse));
      } on Error {
        emit(const MoviesError(
            "Unable to fetch data. Please check your internet connection!"));
      }
    });
  }
}
