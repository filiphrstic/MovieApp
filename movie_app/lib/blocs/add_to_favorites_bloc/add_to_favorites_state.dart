part of 'add_to_favorites_bloc.dart';

abstract class AddToFavoritesState extends Equatable {
  const AddToFavoritesState();
}

class AddToFavoritesInitial extends AddToFavoritesState {
  @override
  List<Object> get props => [];
}

class AddToFavoritesLoaded extends AddToFavoritesState {
  final String buttonString;
  final bool movieAddedToFavorites;

  const AddToFavoritesLoaded(this.buttonString, this.movieAddedToFavorites);

  @override
  List<Object> get props => [];
}

class MovieAddedToFavorites extends AddToFavoritesState {
  final String buttonString;
  final bool movieAdded;

  const MovieAddedToFavorites(this.buttonString, this.movieAdded);

  @override
  List<Object> get props => [];
}
