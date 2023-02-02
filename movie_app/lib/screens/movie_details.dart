import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/add_to_favorites_bloc/add_to_favorites_bloc.dart';
import 'package:movie_app/blocs/cast_members_bloc/cast_members_bloc.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/screen_arguments/chosen_movie.dart';
import 'package:movie_app/utilities/environment_variables.dart';
import 'package:movie_app/widgets/bars/appbar.dart';
import 'package:movie_app/widgets/bars/bottom_navbar.dart';
import 'package:movie_app/widgets/cast_members/cast_members_list.dart';

class MovieDetailsPage extends StatefulWidget {
  final ChosenMovie chosenMovie;
  const MovieDetailsPage({super.key, required this.chosenMovie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final CastMembersBloc castMembersBloc = CastMembersBloc();
  final AddToFavoritesBloc addToFavoritesBloc = AddToFavoritesBloc();

  @override
  void initState() {
    castMembersBloc.add(GetCastMembersList(widget.chosenMovie.chosenMovie.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addToFavoritesBloc
        ..add(LoadMovieDetailsScreenEvent(widget.chosenMovie.chosenMovie)),
      child: Scaffold(
        appBar: const AppbarWidget(isHomepage: false),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    widget.chosenMovie.chosenMovie.originalTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Image.network(EnvironmentConfig.IMAGE_BASE_URL +
                            widget.chosenMovie.chosenMovie.posterPath),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Release date',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(widget.chosenMovie.chosenMovie.releaseDate),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text('Rating',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                              Text(widget.chosenMovie.chosenMovie.voteAverage),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text('Synopsis',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 40,
                                height: 150,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    widget.chosenMovie.chosenMovie.overview,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocConsumer<AddToFavoritesBloc, AddToFavoritesState>(
                      buildWhen: (previous, current) {
                    return current is AddToFavoritesLoaded ||
                        current is MovieAddedToFavorites ||
                        current is MovieRemovedFromFavorites;
                  }, listener: (context, state) {
                    if (state is MovieAddedToFavorites) {
                      final snackbarMessage = SnackBar(
                        content: Text(
                            '"${widget.chosenMovie.chosenMovie.originalTitle}" has been added to favorites'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackbarMessage);
                    } else if (state is MovieRemovedFromFavorites) {
                      final snackbarMessage = SnackBar(
                        content: Text(
                            '"${widget.chosenMovie.chosenMovie.originalTitle}" has been removed from favorites'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackbarMessage);
                    }
                  }, builder: (context, state) {
                    if (state is AddToFavoritesLoaded) {
                      if (state.movieAddedToFavorites) {
                        return removeFromFavoritesButton(
                            addToFavoritesBloc,
                            widget.chosenMovie.chosenMovie,
                            state.movieAddedToFavorites,
                            state.buttonString);
                      } else {
                        return addToFavoritesButton(
                            addToFavoritesBloc,
                            widget.chosenMovie.chosenMovie,
                            state.movieAddedToFavorites,
                            state.buttonString);
                      }
                    }
                    if (state is MovieAddedToFavorites) {
                      return removeFromFavoritesButton(
                          addToFavoritesBloc,
                          widget.chosenMovie.chosenMovie,
                          state.movieAddedToFavorites,
                          state.buttonString);
                    }
                    if (state is MovieRemovedFromFavorites) {
                      return addToFavoritesButton(
                          addToFavoritesBloc,
                          widget.chosenMovie.chosenMovie,
                          state.movieAddedToFavorites,
                          state.buttonString);
                    } else {
                      return Container();
                    }
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cast',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: buildCastMembersList(
                      castMembersBloc, widget.chosenMovie.chosenMovie.id),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(),
      ),
    );
  }
}

Widget addToFavoritesButton(AddToFavoritesBloc addToFavoritesBloc, Movie movie,
    bool movieAdded, String buttonString) {
  return ElevatedButton.icon(
    onPressed: () async {
      addToFavoritesBloc.add(AddToFavoritesClickEvent(movie, movieAdded));
    },
    icon: const Icon(Icons.favorite),
    label: Text(buttonString),
  );
}

Widget removeFromFavoritesButton(AddToFavoritesBloc addToFavoritesBloc,
    Movie movie, bool movieAdded, String buttonString) {
  return ElevatedButton.icon(
    onPressed: () async {
      addToFavoritesBloc.add(RemoveFromFavoritesClickEvent(movie, movieAdded));
    },
    icon: const Icon(Icons.favorite),
    label: Text(buttonString),
  );
}
