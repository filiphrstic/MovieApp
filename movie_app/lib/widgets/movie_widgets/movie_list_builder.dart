import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movies_bloc/movie_bloc.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/widgets/movie_widgets/movie_card_builder.dart';

Widget buildMovieList(BuildContext context, List<Movie> moviesList) {
  final MovieBloc testBloc = MovieBloc();

  return BlocProvider(
    create: (context) => testBloc,
    child: BlocListener<MovieBloc, MovieState>(
      listener: (context, state) {
        if (state is PopularMoviesLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Movies loaded'),
          ));
        }
      },
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return buildLoading();
          }
          if (state is PopularMoviesLoadedState) {
            return Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.metrics.atEdge &&
                      notification.metrics.pixels > 0) {
                    testBloc.add(GetMorePopularMoviesList(
                        state.popularMoviesResponse.popularMoviesList!,
                        state.popularMoviesResponse.currentPage!));
                  }
                  return true;
                },
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:
                      state.popularMoviesResponse.popularMoviesList!.length,
                  itemBuilder: ((context, index) {
                    return buildMovieCard(context, index,
                        state.popularMoviesResponse.popularMoviesList!);
                  }),
                ),
              ),
            );
          }
          if (state is MovieInitialState) {
            testBloc.add(GetPopularMoviesList());
            return buildLoading();
          } else {
            return Container(
              child: Text(state.toString()),
            );
          }
        },
      ),
    ),
  );
}

Widget buildFavoriteMovieList(BuildContext context, List<Movie> moviesList) {
  return Expanded(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: moviesList.length,
      itemBuilder: ((context, index) {
        return buildMovieCard(context, index, moviesList);
      }),
    ),
  );
}

Widget buildLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
