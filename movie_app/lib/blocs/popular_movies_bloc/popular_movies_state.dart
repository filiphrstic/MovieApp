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

class PopularMoviesError extends PopularMoviesState {
  final String? message;
  const PopularMoviesError(this.message);
}
