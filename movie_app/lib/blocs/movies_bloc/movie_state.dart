part of 'movie_bloc.dart';

/*
MovieLoadingState - state where loading indicator is displayed

PopularMoviesLoadedState - becomes active after popular movies 
have been successfully fetched from API

FavoriteMoviesLoadedState- becomes active after favorite movies 
have been successfully fetched from local JSON file

MoviesError - if an error occurs while fetching data
this state enbables to display an error message
*/

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final MovieResponse popularMoviesResponse;
  const MovieLoadedState(this.popularMoviesResponse);
}

class FavoriteMoviesLoadedState extends MovieState {
  final List<Movie> favoriteMoviesResponse;
  const FavoriteMoviesLoadedState(this.favoriteMoviesResponse);
}

class MoviesError extends MovieState {
  final String? message;
  const MoviesError(this.message);
}
