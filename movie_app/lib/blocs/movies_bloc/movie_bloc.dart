import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/classes/popular_movies_response.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/providers/file_handler.dart';
import 'package:movie_app/providers/tmdb_provider.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitialState()) {
    final TmdbProvider tmdbProvider = TmdbProvider();

    on<GetPopularMoviesList>((event, emit) async {
      try {
        emit(MovieLoadingState());
        final response = await tmdbProvider.fetchPopularMovies(1);
        emit(PopularMoviesLoadedState(response));
        if (response.error != null) {
          emit(MoviesError(response.error));
        }
      } on NetworkError {
        emit(const MoviesError(
            "Unable to fetch data. Please check your internet connection!"));
      }
    });

    on<GetMorePopularMoviesList>((event, emit) async {
      try {
        emit(MovieLoadingState());
        final response =
            await tmdbProvider.fetchPopularMovies(event.previousPage + 1);
        List<Movie> previouslyFetchedMovies = event.previouslyFetchedMovies;
        List<Movie> newlyFetchedMovies = response.popularMoviesList!;
        previouslyFetchedMovies.addAll(newlyFetchedMovies);
        response.popularMoviesList = previouslyFetchedMovies;
        // event.previouslyFetchedMovies.addAll(response..popularMoviesList!);
        emit(PopularMoviesLoadedState(response));
        if (response.error != null) {
          emit(MoviesError(response.error));
        }
      } on NetworkError {
        emit(const MoviesError(
            "Unable to fetch data. Please check your internet connection!"));
      }
    });

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
  }
}
