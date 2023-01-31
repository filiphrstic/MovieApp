import 'package:flutter/material.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/navigation/routes.dart';
import 'package:movie_app/screen_arguments/chosen_movie.dart';
import 'package:movie_app/utilities/environment_variables.dart';

Widget buildPopularMovieCard(
    BuildContext context, List<Movie> popularMoviesList) {
  return Expanded(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: popularMoviesList.length,
      itemBuilder: ((context, index) {
        return Container(
          margin: const EdgeInsets.all(10.0),
          child: Card(
            child: InkWell(
              onTap: () {
                ChosenMovie chosenMovie = ChosenMovie(popularMoviesList[index]);
                Navigator.pushNamed(context, movieDetailsScreenRoute,
                    arguments: chosenMovie);
              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                        EnvironmentConfig.IMAGE_BASE_URL +
                            popularMoviesList[index].posterPath,
                        scale: 1.65),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              popularMoviesList[index].originalTitle,
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.clip,
                              maxLines: 5,
                              softWrap: true,
                            ),
                          ),
                          Text(
                            popularMoviesList[index].releaseDate,
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
      }),
    ),
  );
}