part of 'add_to_favorites_bloc.dart';

/*
There are four possible states for this scenario:
1. AddToFavoritesInitial
2. AddToFavoritesLoaded - This means that the movie check (if the movie has already been added to favorites) 
has completed and the button is displayed properly. There is a helper bool property "movieAddedToFavorites"
to easily check later what button to show on movie details page.
3. MovieAddedToFavorites - This state is active after a user adds a new movie to favorites, it enables the app to change the button accordingly
4. MovieRemovedFromFavorites - Opposite of 3.
*/

abstract class AddToFavoritesState extends Equatable {
  const AddToFavoritesState();
}

class AddToFavoritesInitial extends AddToFavoritesState {
  @override
  List<Object> get props => [];
}

class AddToFavoritesLoaded extends AddToFavoritesState {
  final bool movieAddedToFavorites;
  const AddToFavoritesLoaded(this.movieAddedToFavorites);

  @override
  List<Object> get props => [];
}

class MovieAddedToFavorites extends AddToFavoritesState {
  const MovieAddedToFavorites();

  @override
  List<Object> get props => [];
}

class MovieRemovedFromFavorites extends AddToFavoritesState {
  const MovieRemovedFromFavorites();

  @override
  List<Object> get props => [];
}
