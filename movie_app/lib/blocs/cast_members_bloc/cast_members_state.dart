part of 'cast_members_bloc.dart';

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
