part of 'add_to_favorites_bloc.dart';

/*
These are all possible events that trigger "add_to_favorites_bloc".
1. When movie details page has been loaded
2. When user clicks on "Add to favorites" button
3. When user clicks on "Remove from favorites" button

The classes have "Movie" parameter so that the bloc class 
can use it to add/remove a movie and to check if the movie is already added 
*/

abstract class AddToFavoritesEvent extends Equatable {
  const AddToFavoritesEvent();
}

class LoadMovieDetailsScreenEvent extends AddToFavoritesEvent {
  final Movie movie;
  const LoadMovieDetailsScreenEvent(this.movie);
  @override
  List<Object> get props => [movie];
}

class AddToFavoritesClickEvent extends AddToFavoritesEvent {
  final Movie movie;
  const AddToFavoritesClickEvent(this.movie);
  @override
  List<Object> get props => [movie];
}

class RemoveFromFavoritesClickEvent extends AddToFavoritesEvent {
  final Movie movie;
  const RemoveFromFavoritesClickEvent(this.movie);
  @override
  List<Object> get props => [movie];
}
