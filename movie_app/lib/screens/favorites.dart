import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/providers/file_handler.dart';
import 'package:movie_app/widgets/appbar.dart';
import 'package:movie_app/widgets/bottom_navbar.dart';
import 'package:movie_app/widgets/popular_movie_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Movie> favouriteMoviesList = [];

  readFavoriteMovies() async {
    favouriteMoviesList = await FileHandler.instance
        .readFavoriteMovies()
        .then((value) => favouriteMoviesList = value);
    // return favouriteMoviesList;
    // favouriteMoviesList.forEach((element) {
    //   print("favorite movie:  " + element.originalTitle);
    // });
    // if (favouriteMoviesList.isEmpty) {
    //   print("prazno");
    // } else
    //   print("nije prazno");
  }

  @override
  Widget build(BuildContext context) {
    // List<Movie> favouriteMoviesList = readFavoriteMovies();
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
                buildPopularMovieCard(context, favouriteMoviesList)
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavbar());
  }
}
