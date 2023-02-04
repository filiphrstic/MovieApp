import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movies/movie.dart';
import 'package:movie_app/providers/file_handler.dart';

part 'add_to_favorites_event.dart';
part 'add_to_favorites_state.dart';

/*
This class responds to three events:
1. When movie details page has been loaded - it checks whether the movie has already been added to favorites or not.
2. When user clicks on "Add to favorites" button - it adds a new movie to local JSON file using FileHandler
3. When user clicks on "Remove from favorites" button - it removes a movie from local JSON file using FileHandler
*/

class AddToFavoritesBloc
    extends Bloc<AddToFavoritesEvent, AddToFavoritesState> {
  AddToFavoritesBloc() : super(AddToFavoritesInitial()) {
    on<LoadMovieDetailsScreenEvent>((event, emit) async {
      List<Movie> response = [];
      response = await FileHandler.instance
          .readFavoriteMovies()
          .then((value) => response = value);
      if (response.contains(event.movie)) {
        emit(const AddToFavoritesLoaded(true));
      } else {
        emit(const AddToFavoritesLoaded(false));
      }
    });

    on<AddToFavoritesClickEvent>((event, emit) async {
      await FileHandler.instance.writeMovie(event.movie);
      emit(const MovieAddedToFavorites());
    });

    on<RemoveFromFavoritesClickEvent>((event, emit) async {
      await FileHandler.instance.deleteFavoriteMovie(event.movie);
      emit(const MovieRemovedFromFavorites());
    });
  }
}
