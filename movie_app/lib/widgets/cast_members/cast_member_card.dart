import 'package:flutter/material.dart';
import 'package:movie_app/classes/cast_member.dart';
import 'package:movie_app/classes/movie.dart';
import 'package:movie_app/classes/popular_movies_response.dart';
import 'package:movie_app/navigation/routes.dart';
import 'package:movie_app/screen_arguments/chosen_movie.dart';
import 'package:movie_app/utilities/environment_variables.dart';

Widget buildCastMemberCard(
    BuildContext context, List<CastMember> castMembersList) {
  return Expanded(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: castMembersList.length,
      itemBuilder: ((context, index) {
        return Container(
          margin: const EdgeInsets.all(10.0),
          child: Card(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  castMembersList[index].profilePath != null
                      ? Image.network(
                          EnvironmentConfig.IMAGE_BASE_URL +
                              castMembersList[index].profilePath!,
                          scale: 2.5)
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            castMembersList[index].name,
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.clip,
                            maxLines: 5,
                            softWrap: true,
                          ),
                        ),
                        castMembersList[index].character != null
                            ? Text(
                                castMembersList[index].character!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ),
  );
}
