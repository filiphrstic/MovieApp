part of 'add_to_favorites_bloc.dart';

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
  final bool movieAlreadyAdded;
  const AddToFavoritesClickEvent(this.movie, this.movieAlreadyAdded);
  @override
  List<Object> get props => [movie];
}
