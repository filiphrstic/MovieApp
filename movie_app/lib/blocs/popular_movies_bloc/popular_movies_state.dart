part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object?> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  final PopularMoviesResponse popularMoviesResponse;
  const PopularMoviesLoaded(this.popularMoviesResponse);
}

//za favorite
class FavoriteMoviesLoaded extends PopularMoviesState {
  final List<Movie> favoriteMoviesResponse;
  const FavoriteMoviesLoaded(this.favoriteMoviesResponse);
}

class PopularMoviesError extends PopularMoviesState {
  final String? message;
  const PopularMoviesError(this.message);
}
