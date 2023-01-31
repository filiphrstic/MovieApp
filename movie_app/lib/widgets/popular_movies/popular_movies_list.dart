import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movie_app/widgets/popular_movies/popular_movie_card.dart';

Widget buildPopularMoviesList(PopularMoviesBloc popularMoviesBloc) {
  return BlocProvider(
    create: (_) => popularMoviesBloc,
    child: BlocListener<PopularMoviesBloc, PopularMoviesState>(
      listener: (context, state) {
        if (state is PopularMoviesError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message!),
          ));
        }
      },
      child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
        builder: (context, state) {
          if (state is PopularMoviesInitial) {
            return buildLoading();
          } else if (state is PopularMoviesLoading) {
            return buildLoading();
          } else if (state is PopularMoviesLoaded) {
            return buildPopularMovieCard(
                context, state.popularMoviesResponse.popularMoviesList!);
          } else if (state is PopularMoviesError) {
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
