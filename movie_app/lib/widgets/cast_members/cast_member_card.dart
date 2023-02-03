import 'package:flutter/material.dart';
import 'package:movie_app/classes/cast_member.dart';
import 'package:movie_app/utilities/environment_variables.dart';

Widget buildCastMemberCard(BuildContext context, CastMember castMember) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    child: Card(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            castMember.profilePath!.isEmpty
                ? SizedBox(
                    width: 75,
                    child: Image.asset(
                      'lib/assets/images/unavailable-image.jpg',
                    ))
                : SizedBox(
                    width: 75,
                    child: FadeInImage(
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                            'lib/assets/images/unavailable-image.jpg');
                      },
                      placeholder:
                          const AssetImage('lib/assets/images/loading.gif'),
                      image: NetworkImage(EnvironmentConfig.IMAGE_BASE_URL +
                          castMember.profilePath!),
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
                      castMember.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.clip,
                      maxLines: 5,
                      softWrap: true,
                    ),
                  ),
                  castMember.character != null
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            castMember.character!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            'Character name not provided',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
