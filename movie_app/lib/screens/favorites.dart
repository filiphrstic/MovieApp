import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/providers/file_handler.dart';
import 'package:movie_app/widgets/bars/appbar.dart';
import 'package:movie_app/widgets/bars/bottom_navbar.dart';
import 'package:movie_app/widgets/popular_movies/popular_movie_card.dart';
import 'package:movie_app/widgets/popular_movies/popular_movies_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // List<Movie> favouriteMoviesList = [];
  final PopularMoviesBloc popularMoviesBloc = PopularMoviesBloc();

  // readFavoriteMovies() async {
  //   favouriteMoviesList = await FileHandler.instance
  //       .readFavoriteMovies()
  //       .then((value) => favouriteMoviesList = value);
  // }
  @override
  void initState() {
    popularMoviesBloc.add(GetFavoriteMoviesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // readFavoriteMovies();
    return Scaffold(
        appBar: const AppbarWidget(),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to leave')),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Favorites',
                  style: Theme.of(context).textTheme.headline2,
                ),
                // buildPopularMovieCard(context, favouriteMoviesList)
                buildPopularMoviesList(popularMoviesBloc, true),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavbar());
  }
}
