import 'package:flutter/material.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/navigation/routes.dart';
import 'package:movie_app/screen_arguments/chosen_movie.dart';
import 'package:movie_app/utilities/environment_variables.dart';
import 'package:movie_app/widgets/loading/loading_widgets.dart';

Widget buildMovieCard(BuildContext context, int index, Movie movie) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    child: Card(
      child: InkWell(
        onTap: () {
          ChosenMovie chosenMovie = ChosenMovie(movie);
          Navigator.pushNamed(context, movieDetailsScreenRoute,
              arguments: chosenMovie);
        },
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (movie.posterPath == 'https://i.imgur.com/DiIF5t6.jpeg')
                  ? SizedBox(
                      width: 100,
                      height: 150,
                      child: Image.network(
                        movie.posterPath,
                      ))
                  : SizedBox(
                      width: 100,
                      height: 150,
                      child: Image.network(
                        EnvironmentConfig.IMAGE_BASE_URL + movie.posterPath,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return buildLoadingProgressIndicator(loadingProgress);
                        },
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
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
