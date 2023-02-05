import 'package:flutter/material.dart';
import 'package:movie_app/models/cast_members/cast_member.dart';
import 'package:movie_app/widgets/images/image_builder.dart';

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
              ? buildImageUnavailable(75, null)
              : buildImage(75, null, castMember.profilePath),
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
