import 'package:flutter/material.dart';
import 'package:movie_app/models/cast_members/cast_member.dart';
import 'package:movie_app/utilities/environment_variables.dart';

Widget buildCastMemberCard(BuildContext context, CastMember castMember) {
  final screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Card(
      elevation: 2.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          castMember.profilePath!.isEmpty
              ? SizedBox(
                  width: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.asset(
                      'lib/assets/images/image_unavailable.png',
                    ),
                  ))
              : SizedBox(
                  width: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: FadeInImage(
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                            'lib/assets/images/image_unavailable.png');
                      },
                      placeholder:
                          const AssetImage('lib/assets/images/loading.gif'),
                      image: NetworkImage(EnvironmentConfig.IMAGE_BASE_URL +
                          castMember.profilePath!),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth / 2,
                  child: Text(
                    castMember.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.clip,
                    maxLines: 5,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  width: screenWidth / 2,
                  child: Text(
                    castMember.character!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
