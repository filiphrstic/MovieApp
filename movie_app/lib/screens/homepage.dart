import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/movies_bloc/movie_bloc.dart';
import 'package:movie_app/widgets/bars/appbar.dart';
import 'package:movie_app/widgets/bars/bottom_navbar.dart';
import 'package:movie_app/widgets/movie_widgets/movie_list_builder.dart';
import 'package:movie_app/widgets/movie_widgets/movie_list_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final MovieBloc popularMoviesBloc = MovieBloc();

  @override
  void initState() {
    // popularMoviesBloc.add(GetPopularMoviesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppbarWidget(),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to leave')),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Popular movies',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              // buildMovieListHandler(popularMoviesBloc, false),
              buildMovieList(context, [])
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavbar());
  }
}
