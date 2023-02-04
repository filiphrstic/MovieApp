import 'package:flutter/material.dart';
import 'package:movie_app/models/movies/movie.dart';
import 'package:movie_app/navigation/routes.dart';
import 'package:movie_app/screen_arguments/chosen_movie.dart';
import 'package:movie_app/utilities/environment_variables.dart';

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
              (movie.posterPath.isEmpty)
                  ? SizedBox(
                      width: 100,
                      height: 150,
                      child: Image.asset(
                        'lib/assets/images/unavailable-image.jpg',
                      ))
                  : SizedBox(
                      width: 100,
                      height: 150,
                      child: FadeInImage(
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                              'lib/assets/images/unavailable-image.jpg');
                        },
                        placeholder:
                            const AssetImage('lib/assets/images/loading.gif'),
                        image: NetworkImage(EnvironmentConfig.IMAGE_BASE_URL +
                            movie.posterPath),
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
