import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movies_bloc/movie_bloc.dart';
import 'package:movie_app/widgets/movie_widgets/movie_list_builder.dart';

Widget buildMovieListHandler(MovieBloc movieBloc, bool favoriteBool) {
  return BlocProvider(
    create: (_) => movieBloc,
    child: BlocListener<MovieBloc, MovieState>(
      listener: (context, state) {
        if (state is MoviesError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message!),
          ));
        }
      },
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitialState) {
            return buildLoading();
          } else if (state is MovieLoadingState) {
            return buildLoading();
          } else if (state is PopularMoviesLoadedState && !favoriteBool) {
            return buildMovieList(
                context, state.popularMoviesResponse.popularMoviesList!);
          } else if (state is FavoriteMoviesLoadedState && favoriteBool) {
            return buildMovieList(context, state.favoriteMoviesResponse);
          } else if (state is MoviesError) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
    ),
  );
}

Widget buildLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
