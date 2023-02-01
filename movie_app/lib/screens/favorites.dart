import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movie_app/widgets/bars/appbar.dart';
import 'package:movie_app/widgets/bars/bottom_navbar.dart';
import 'package:movie_app/widgets/popular_movies/popular_movies_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final PopularMoviesBloc popularMoviesBloc = PopularMoviesBloc();
  @override
  void initState() {
    popularMoviesBloc.add(GetFavoriteMoviesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppbarWidget(),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to leave')),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Favorite movies',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                buildPopularMoviesList(popularMoviesBloc, true),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavbar());
  }
}
