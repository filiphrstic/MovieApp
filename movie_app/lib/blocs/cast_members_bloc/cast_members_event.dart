part of 'cast_members_bloc.dart';

/*
There is only one event in this scenario and it is triggered
when movie details page is loaded
*/

abstract class CastMembersEvent extends Equatable {
  const CastMembersEvent();

  @override
  List<Object> get props => [];
}

class GetCastMembersList extends CastMembersEvent {
  final int movieID;

  const GetCastMembersList(this.movieID);
}
