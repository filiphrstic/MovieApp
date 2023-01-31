import 'package:movie_app/classes/cast_member.dart';

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
