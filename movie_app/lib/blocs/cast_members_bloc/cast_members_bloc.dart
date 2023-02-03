import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/classes/cast_members_response.dart';
import 'package:movie_app/providers/tmdb_provider.dart';

part 'cast_members_event.dart';
part 'cast_members_state.dart';

//Fetching cast members from API and emiting event with response after it's loaded

class CastMembersBloc extends Bloc<CastMembersEvent, CastMembersState> {
  CastMembersBloc() : super(const CastMembersInitial()) {
    final TmdbProvider tmdbProvider = TmdbProvider();

    on<GetCastMembersList>((event, emit) async {
      try {
        emit(CastMembersLoading());
        final response = await tmdbProvider.fetchCastMembers(event.movieID);
        emit(CastMembersLoaded(response));
        if (response.error != null) {
          emit(CastMembersError(response.error));
        }
      } on NetworkError {
        emit(const CastMembersError(
            "Unable to fetch data. Please check your internet connection!"));
      }
    });
  }
}
