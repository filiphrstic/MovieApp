part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesList extends MovieEvent {}

class GetMorePopularMoviesList extends MovieEvent {
  final List<Movie> previouslyFetchedMovies;
  final int previousPage;
  const GetMorePopularMoviesList(
      this.previouslyFetchedMovies, this.previousPage);
}

class GetSearchResultsMovieList extends MovieEvent {
  final String query;
  const GetSearchResultsMovieList(this.query);
}

class GetFavoriteMoviesList extends MovieEvent {}