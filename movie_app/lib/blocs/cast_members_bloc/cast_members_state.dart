part of 'cast_members_bloc.dart';

/*
CastMembersLoaded state is active after the cast fetching 
has been completed, and it carries a response from API.

CastMembersLoading state enables loading indicator to be 
shown until the data is fetched.

CastMembersError state becomes active if an error occurs
whilst fetching the data from API.
*/

abstract class CastMembersState extends Equatable {
  const CastMembersState();

  @override
  List<Object?> get props => [];
}

class CastMembersInitial extends CastMembersState {
  const CastMembersInitial();
}

class CastMembersLoading extends CastMembersState {}

class CastMembersLoaded extends CastMembersState {
  final CastMembersResponse castMembersResponse;
  const CastMembersLoaded(this.castMembersResponse);
}

class CastMembersError extends CastMembersState {
  final String? message;
  const CastMembersError(this.message);
}
