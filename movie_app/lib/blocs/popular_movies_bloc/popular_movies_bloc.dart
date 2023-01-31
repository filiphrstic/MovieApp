import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/classes/popular_movies_response.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/providers/file_handler.dart';
import 'package:movie_app/providers/tmdb_provider.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc() : super(PopularMoviesInitial()) {
    final TmdbProvider tmdbProvider = TmdbProvider();

    on<GetPopularMoviesList>((event, emit) async {
      try {
        emit(PopularMoviesLoading());
        final response = await tmdbProvider.fetchPopularMovies();
        emit(PopularMoviesLoaded(response));
        if (response.error != null) {
          emit(PopularMoviesError(response.error));
        }
      } on NetworkError {
        emit(const PopularMoviesError(
            "Unable to fetch data. Please check your internet connection!"));
      }
    });

    on<GetFavoriteMoviesList>((event, emit) async {
      try {
        emit(PopularMoviesLoading());
        // final response = await tmdbProvider.fetchPopularMovies();
        List<Movie> response = [];
        response = await FileHandler.instance
            .readFavoriteMovies()
            .then((value) => response = value);

        emit(FavoriteMoviesLoaded(response));
        // if (response.error != null) {
        // emit(PopularMoviesError(response.error));
        // }
      } on NetworkError {
        emit(const PopularMoviesError(
            "Unable to fetch data. Please check your internet connection!"));
      }
    });
  }
}
