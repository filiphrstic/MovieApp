import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/providers/file_handler.dart';

part 'add_to_favorites_event.dart';
part 'add_to_favorites_state.dart';

class AddToFavoritesBloc
    extends Bloc<AddToFavoritesEvent, AddToFavoritesState> {
  AddToFavoritesBloc() : super(AddToFavoritesInitial()) {
    on<LoadMovieDetailsScreenEvent>((event, emit) async {
      List<Movie> response = [];
      response = await FileHandler.instance
          .readFavoriteMovies()
          .then((value) => response = value);
      if (response.contains(event.movie)) {
        emit(const AddToFavoritesLoaded('Remove from favorites', true));
      } else {
        emit(const AddToFavoritesLoaded('Add to favorites', false));
      }
    });

    on<AddToFavoritesClickEvent>((event, emit) async {
      if (!event.movieAlreadyAdded) {
        await FileHandler.instance.writeMovie(event.movie);
        emit(const MovieAddedToFavorites('Remove from favorites', true));
      } else if (event.movieAlreadyAdded) {
        await FileHandler.instance.deleteFavoriteMovie(event.movie);
        emit(const MovieAddedToFavorites('Add to favorites', false));
      }
    });

    on<RemoveFromFavoritesClickEvent>((event, emit) async {
      if (!event.movieAlreadyAdded) {
        await FileHandler.instance.writeMovie(event.movie);
        emit(const MovieAddedToFavorites('Remove from favorites', true));
      } else if (event.movieAlreadyAdded) {
        await FileHandler.instance.deleteFavoriteMovie(event.movie);
        emit(const MovieRemovedFromFavorites('Add to favorites', false));
      }
    });
  }
}
