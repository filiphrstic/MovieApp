import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movies_bloc/movie_bloc.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/widgets/movie_widgets/movie_card_builder.dart';

Widget buildMovieList(BuildContext context) {
  final MovieBloc movieBloc = MovieBloc();

  return BlocProvider(
    create: (context) => movieBloc,
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
          if (state is MovieInitialState) {
            movieBloc.add(GetPopularMoviesList());
            return buildLoading();
          }
          if (state is MovieLoadingState) {
            return buildLoading();
          }
          if (state is PopularMoviesLoadedState) {
            return Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.metrics.atEdge &&
                      notification.metrics.pixels > 0) {
                    movieBloc.add(GetMorePopularMoviesList(
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
          if (state is MoviesError) {
            return Text(state.message.toString());
          } else {
            return Container();
          }
        },
      ),
    ),
  );
}

// Widget buildSearchResultsMovieList(BuildContext context, String query) {
//   final MovieBloc searchResultsMovieBloc = MovieBloc();

//   return BlocProvider(
//     create: (context) => searchResultsMovieBloc,
//     child: BlocListener<MovieBloc, MovieState>(
//       listener: (context, state) {
//         if (state is PopularMoviesLoadedState) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text('Search results loaded'),
//           ));
//         }
//       },
//       child: BlocBuilder<MovieBloc, MovieState>(
//         builder: (context, state) {
//           if (state is MovieInitialState) {
//             searchResultsMovieBloc.add(GetSearchResultsMovieList(query));
//             return buildLoading();
//           }
//           if (state is MovieLoadingState) {
//             return buildLoading();
//           }
//           if (state is PopularMoviesLoadedState) {
//             return Expanded(
//               // child: NotificationListener<ScrollEndNotification>(
//               //   onNotification: (notification) {
//               //     if (notification.metrics.atEdge &&
//               //         notification.metrics.pixels > 0) {
//               //       searchResultsMovieBloc.add(GetMorePopularMoviesList(
//               //           state.popularMoviesResponse.popularMoviesList!,
//               //           state.popularMoviesResponse.currentPage!));
//               //     }
//               //     return true;
//               //   },
//               child: ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount:
//                     state.popularMoviesResponse.popularMoviesList!.length,
//                 itemBuilder: ((context, index) {
//                   return buildMovieCard(context, index,
//                       state.popularMoviesResponse.popularMoviesList!);
//                 }),
//               ),
//               // ),
//             );
//           }
//           if (state is MoviesError) {
//             return Text(state.message.toString());
//           } else {
//             return Container();
//           }
//         },
//       ),
//     ),
//   );
// }

Widget buildSearchResultsMovieList(
    BuildContext context, MovieBloc searchResultsMovieBloc) {
  // final MovieBloc searchResultsMovieBloc = MovieBloc();

  return BlocProvider(
    create: (context) => searchResultsMovieBloc,
    child: BlocListener<MovieBloc, MovieState>(
      listener: (context, state) {
        if (state is PopularMoviesLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Search results loaded'),
          ));
        }
      },
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitialState) {
            // searchResultsMovieBloc.add(GetSearchResultsMovieList(query));
            // return buildLoading();
            return Text('Your search results will be displayed here');
          }
          if (state is MovieLoadingState) {
            return buildLoading();
          }
          if (state is PopularMoviesLoadedState) {
            return Expanded(
              // child: NotificationListener<ScrollEndNotification>(
              //   onNotification: (notification) {
              //     if (notification.metrics.atEdge &&
              //         notification.metrics.pixels > 0) {
              //       searchResultsMovieBloc.add(GetMorePopularMoviesList(
              //           state.popularMoviesResponse.popularMoviesList!,
              //           state.popularMoviesResponse.currentPage!));
              //     }
              //     return true;
              //   },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount:
                    state.popularMoviesResponse.popularMoviesList!.length,
                itemBuilder: ((context, index) {
                  return buildMovieCard(context, index,
                      state.popularMoviesResponse.popularMoviesList!);
                }),
              ),
              // ),
            );
          }
          if (state is MoviesError) {
            return Text(state.message.toString());
          } else {
            return Container();
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
