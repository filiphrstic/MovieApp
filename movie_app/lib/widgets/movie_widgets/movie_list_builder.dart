import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/checkbox_cubit/checkbox_cubit.dart';
import 'package:movie_app/blocs/movies_bloc/movie_bloc.dart';
import 'package:movie_app/models/movies/movie.dart';
import 'package:movie_app/utilities/themes.dart';
import 'package:movie_app/widgets/loading/loading_widgets.dart';
import 'package:movie_app/widgets/movie_widgets/movie_card_builder.dart';

/*
Builds list of popular movies on the homepage based on API response.
While it waits for response it builds loading indicator.
Building a movie list is triggered instantly, on MovieInitialState (when a homepage is loaded).
If a user reaches end of the list, a new event is triggered that fetches another batch of movies. 
This approach is wrong because it just recreates a ListView which now has more items to show. 
That is why after reaching the end, the whole screen reloads and bounces back to the top.
*/
Widget buildMovieList(BuildContext context) {
  final MovieBloc movieBloc = MovieBloc();
  return BlocProvider(
    create: (context) => movieBloc,
    child: BlocListener<MovieBloc, MovieState>(
      listener: (context, state) {},
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitialState) {
            movieBloc.add(GetPopularMoviesList());
            return buildLoading();
          }
          if (state is MovieLoadingState) {
            return buildLoading();
          }
          if (state is MovieLoadedState) {
            return Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.metrics.atEdge &&
                      notification.metrics.pixels > 0) {
                    movieBloc.add(GetMorePopularMoviesList(
                        state.popularMoviesResponse.moviesList!,
                        state.popularMoviesResponse.currentPage!));
                  }
                  return true;
                },
                child: Scrollbar(
                  child: Container(
                    color: backgroundColor,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.popularMoviesResponse.moviesList!.length,
                      itemBuilder: ((context, index) {
                        final Movie popularMovie =
                            state.popularMoviesResponse.moviesList![index];
                        return buildMovieCard(context, index, popularMovie);
                      }),
                    ),
                  ),
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

/*
Builds search results after the user clicks on the search button.
Prior to that the widget will return a simple text message.
*/
Widget buildSearchResultsMovieList(
    BuildContext context, MovieBloc searchResultsMovieBloc) {
  final checkboxCubit = CheckboxCubit();
  final List<int> chosenGenreIds = [];
  return BlocProvider(
    create: (context) => searchResultsMovieBloc,
    child: BlocListener<MovieBloc, MovieState>(
      listener: (context, state) {},
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitialState) {
            return const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text('Your search results will be displayed here'),
            );
          }
          if (state is MovieLoadingState) {
            return buildLoading();
          }
          if (state is MovieLoadedState) {
            if (state.popularMoviesResponse.moviesList == null) {
              return const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text('No results found'),
              );
            } else {
              return Expanded(
                child: Column(
                  children: [
                    // Expanded(
                    // child:
                    BlocProvider(
                      create: (context) => checkboxCubit,
                      child: BlocBuilder<CheckboxCubit, CheckboxState>(
                          builder: (context, checkboxState) {
                        return ExpandablePanel(
                          collapsed: Container(),
                          header: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Filter by genres',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )),
                          expanded: SizedBox(
                            height: 150,
                            child: GridView.builder(
                                itemCount: state
                                    .popularMoviesResponse.genresList!.length,
                                itemBuilder: (context, index) {
                                  final genre = state
                                      .popularMoviesResponse.genresList![index];
                                  return CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      activeColor: primaryColor,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      dense: true,
                                      title: Text(genre.name),
                                      value: genre.isChecked,
                                      onChanged: ((value) {
                                        genre.isChecked = value!;
                                        checkboxCubit.changeValue(value);
                                        if (value) {
                                          chosenGenreIds.add(genre.id);
                                        } else {
                                          chosenGenreIds.removeWhere(
                                              (element) => element == genre.id);
                                        }
                                        searchResultsMovieBloc.add(
                                            FilterChosenEvent(chosenGenreIds,
                                                state.popularMoviesResponse));
                                      }));
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 6,
                                )),
                          ),
                        );
                      }),
                    ),
                    // ),

                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            state.popularMoviesResponse.moviesList!.length,
                        itemBuilder: ((context, index) {
                          final Movie searchResultMovie =
                              state.popularMoviesResponse.moviesList![index];
                          return buildMovieCard(
                              context, index, searchResultMovie);
                        }),
                      ),
                    ),
                  ],
                ),
              );
            }
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

/*
Builds list of movies for favorite page (without infinite scroll feature).
*/
Widget buildFavoriteMovieList(BuildContext context) {
  final MovieBloc favoriteMoviesBloc = MovieBloc();
  return BlocProvider(
    create: (context) => favoriteMoviesBloc,
    child: BlocListener<MovieBloc, MovieState>(
      listener: (context, state) {},
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitialState) {
            favoriteMoviesBloc.add(GetFavoriteMoviesList());
            return buildLoading();
          }
          if (state is MovieLoadingState) {
            return buildLoading();
          }
          if (state is FavoriteMoviesLoadedState) {
            return Expanded(
              child: Container(
                color: backgroundColor,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.favoriteMoviesResponse.length,
                  itemBuilder: ((context, index) {
                    final Movie favoriteMovie =
                        state.favoriteMoviesResponse[index];
                    return buildMovieCard(context, index, favoriteMovie);
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
