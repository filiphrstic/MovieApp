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
            movieBloc.add(
              GetPopularMoviesList(),
            );
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
                    movieBloc.add(
                      GetMorePopularMoviesList(state.movieResponse.moviesList!,
                          state.movieResponse.currentPage!),
                    );
                  }
                  return true;
                },
                child: Scrollbar(
                  child: Container(
                    color: backgroundColor,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.movieResponse.moviesList!.length,
                      itemBuilder: ((context, index) {
                        final Movie popularMovie =
                            state.movieResponse.moviesList![index];
                        return buildMovieCard(context, index, popularMovie);
                      }),
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is MoviesError) {
            return Text(
              state.message.toString(),
            );
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
  List<int> yearsForDropdown = [];
  for (var i = 1920; i < 2024; i++) {
    yearsForDropdown.add(i);
  }
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
            if (state.movieResponse.moviesList == null) {
              return const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text('No results found'),
              );
            } else {
              return Expanded(
                child: Column(
                  children: [
                    BlocProvider(
                      create: (context) => checkboxCubit,
                      child: BlocBuilder<CheckboxCubit, CheckboxState>(
                          builder: (context, checkboxState) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ExpandablePanel(
                                theme: const ExpandableThemeData(
                                  iconColor: primaryColor,
                                ),
                                collapsed: Container(),
                                header: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Filter by genres',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )),
                                expanded: SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    itemCount: state
                                        .movieResponse.allGenresList!.length,
                                    itemBuilder: (context, index) {
                                      final genre = state
                                          .movieResponse.allGenresList![index];
                                      return CheckboxListTile(
                                        contentPadding:
                                            const EdgeInsets.only(left: 10.0),
                                        activeColor: primaryColor,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        visualDensity:
                                            const VisualDensity(vertical: -4),
                                        title: Text(
                                          genre.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        value: genre.isChecked,
                                        onChanged: ((value) {
                                          genre.isChecked = value!;
                                          checkboxCubit.changeValue(value);
                                          if (value) {
                                            state
                                                .movieResponse.chosenGenresList!
                                                .add(genre.id);
                                          } else {
                                            state
                                                .movieResponse.chosenGenresList!
                                                .removeWhere((element) =>
                                                    element == genre.id);
                                          }
                                          searchResultsMovieBloc.add(
                                            FilterChosenEvent(
                                                state.movieResponse
                                                    .chosenGenresList!,
                                                state.movieResponse.chosenYear,
                                                state.movieResponse),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ExpandablePanel(
                                theme: const ExpandableThemeData(
                                  iconColor: primaryColor,
                                ),
                                collapsed: Container(),
                                header: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Filter by year',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )),
                                expanded: Center(
                                  child: SizedBox(
                                    height: 50,
                                    child: DropdownButton<int>(
                                      iconEnabledColor: primaryColor,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      menuMaxHeight: 400,
                                      items: yearsForDropdown.map((year) {
                                        return DropdownMenuItem(
                                            value: year,
                                            child: Text(year.toString()));
                                      }).toList(),
                                      onChanged: ((value) {
                                        searchResultsMovieBloc.add(
                                          FilterChosenEvent(
                                              state.movieResponse
                                                  .chosenGenresList!,
                                              value,
                                              state.movieResponse),
                                        );
                                      }),
                                      hint: const Text('Select year'),
                                      value: state.movieResponse.chosenYear,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                  icon: const Icon(Icons.cancel),
                                  color: primaryColor,
                                  onPressed: () {
                                    state.movieResponse.chosenGenresList!
                                        .clear();
                                    state.movieResponse.chosenYear = null;
                                    for (var element
                                        in state.movieResponse.allGenresList!) {
                                      element.isChecked = false;
                                    }
                                    searchResultsMovieBloc.add(
                                      FilterChosenEvent(
                                          state.movieResponse.chosenGenresList!,
                                          state.movieResponse.chosenYear,
                                          state.movieResponse),
                                    );
                                  }),
                            ),
                          ],
                        );
                      }),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: state.movieResponse.moviesList!.length,
                        itemBuilder: ((context, index) {
                          final Movie searchResultMovie =
                              state.movieResponse.moviesList![index];
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
