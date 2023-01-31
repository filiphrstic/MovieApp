part of 'popular_movies_bloc.dart';

abstract class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesList extends PopularMoviesEvent {}

class GetFavoriteMoviesList extends PopularMoviesEvent {}
