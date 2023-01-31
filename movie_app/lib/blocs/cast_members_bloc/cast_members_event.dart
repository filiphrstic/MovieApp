part of 'cast_members_bloc.dart';

abstract class CastMembersEvent extends Equatable {
  const CastMembersEvent();

  @override
  List<Object> get props => [];
}

class GetCastMembersList extends CastMembersEvent {
  final int movieID;

  const GetCastMembersList(this.movieID);
}
