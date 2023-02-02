part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesList extends MovieEvent {}

class GetFavoriteMoviesList extends MovieEvent {}
