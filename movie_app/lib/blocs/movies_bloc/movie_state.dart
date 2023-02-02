part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

//case1: fetching popular movies from API
class PopularMoviesLoadedState extends MovieState {
  final PopularMoviesResponse popularMoviesResponse;
  const PopularMoviesLoadedState(this.popularMoviesResponse);
}

//case 2: fetching favorite movies from local storage
class FavoriteMoviesLoadedState extends MovieState {
  final List<Movie> favoriteMoviesResponse;
  const FavoriteMoviesLoadedState(this.favoriteMoviesResponse);
}

class MoviesError extends MovieState {
  final String? message;
  const MoviesError(this.message);
}
