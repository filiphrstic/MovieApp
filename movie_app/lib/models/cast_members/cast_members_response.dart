import 'package:movie_app/models/cast_members/cast_member.dart';

//Stores data from API response, creates instances of CastMember and adds them to a list

class CastMembersResponse {
  int? id;
  List<CastMember>? castList;
  String? error;

  CastMembersResponse({
    required this.id,
    required this.castList,
  });

  CastMembersResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      castList = [];
      json['cast'].forEach((castMember) {
        castList!.add(CastMember.fromJson(castMember));
      });
    }
  }

  CastMembersResponse.withError(String errorMessage) {
    error = errorMessage;
  }
}
