import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/cast_members_bloc/cast_members_bloc.dart';
import 'package:movie_app/widgets/cast_members/cast_member_card.dart';
import 'package:movie_app/widgets/loading/loading_widgets.dart';

/*
This widget is responsible for building loading indicator, cast member list
or error message depending on current state
*/

Widget buildCastMembersList(CastMembersBloc castMembersBloc, int movieID) {
  return BlocProvider(
    create: (_) => castMembersBloc,
    child: BlocListener<CastMembersBloc, CastMembersState>(
      listener: (context, state) {
        if (state is CastMembersError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message!),
          ));
        }
      },
      child: BlocBuilder<CastMembersBloc, CastMembersState>(
        builder: (context, state) {
          if (state is CastMembersInitial) {
            return buildLoading();
          } else if (state is CastMembersLoading) {
            return buildLoading();
          } else if (state is CastMembersLoaded) {
            return Scrollbar(
              child: Container(
                color: Colors.grey[200],
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.castMembersResponse.castList!.length,
                  itemBuilder: (context, index) {
                    final castMember =
                        state.castMembersResponse.castList![index];
                    return buildCastMemberCard(context, castMember);
                  },
                ),
              ),
            );
          } else if (state is CastMembersError) {
            return Text(
              state.message.toString(),
            );
          } else {
            return Container();
          }
        },
      ),
    ),
  );
}
