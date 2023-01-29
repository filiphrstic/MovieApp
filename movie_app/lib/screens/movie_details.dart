import 'package:flutter/material.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/screen_arguments/chosen_movie.dart';
import 'package:movie_app/widgets/appbar.dart';
import 'package:movie_app/widgets/bottom_navbar.dart';

class MovieDetailsPage extends StatefulWidget {
  final ChosenMovie chosenMovie;
  const MovieDetailsPage({super.key, required this.chosenMovie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: Center(child: Text(widget.chosenMovie.chosenMovie.originalTitle)),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
