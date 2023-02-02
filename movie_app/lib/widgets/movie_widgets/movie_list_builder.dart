import 'package:flutter/material.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/widgets/movie_widgets/movie_card_builder.dart';

Widget buildMovieList(BuildContext context, List<Movie> moviesList) {
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
