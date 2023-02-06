part of 'movie_bloc.dart';

/*
GetMorePopularMoviesList event triggers when the homepage
is being initialized.

GetMorePopularMoviesList event is triggered when the user
scrolls to the bottom of the popular movies list on homepage

GetSearchResultsMovieList event is triggered when a user
click "Search" button on search page. It also has a string
parameter that is passed to TmdbProvider which then
composes HTTP link for the API

GetFavoriteMoviesList event is triggered when favorites
page is loaded
*/

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

class GetGenres extends MovieEvent {}

class FilterChosenEvent extends MovieEvent {
  final List<int> chosenGenreIDs;
  final MovieResponse searchResults;

  const FilterChosenEvent(this.chosenGenreIDs, this.searchResults);
}
