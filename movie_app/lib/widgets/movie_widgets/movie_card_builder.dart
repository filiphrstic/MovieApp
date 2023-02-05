import 'package:flutter/material.dart';
import 'package:movie_app/models/movies/movie.dart';
import 'package:movie_app/navigation/routes.dart';
import 'package:movie_app/screen_arguments/chosen_movie.dart';
import 'package:movie_app/widgets/images/image_builder.dart';

Widget buildMovieCard(BuildContext context, int index, Movie movie) {
  final screenWidth = MediaQuery.of(context).size.width;
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
    child: Card(
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          ChosenMovie chosenMovie = ChosenMovie(movie);
          Navigator.pushNamed(context, movieDetailsScreenRoute,
              arguments: chosenMovie);
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (movie.posterPath.isEmpty)
                  ? buildImageUnavailable(100, 150)
                  : buildImage(100, 150, movie.posterPath),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth / 2,
                      child: Text(
                        movie.originalTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        overflow: TextOverflow.clip,
                        maxLines: 5,
                        softWrap: true,
                      ),
                    ),
                    Text(
                      movie.releaseDate,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
