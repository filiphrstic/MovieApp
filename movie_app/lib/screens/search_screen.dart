import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movies_bloc/movie_bloc.dart';
import 'package:movie_app/widgets/bars/appbar.dart';
import 'package:movie_app/widgets/bars/bottom_navbar.dart';
import 'package:movie_app/widgets/movie_widgets/movie_list_builder.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MovieBloc searchMovieBloc = MovieBloc();

    return BlocProvider(
      create: (context) => searchMovieBloc,
      child: BlocListener<MovieBloc, MovieState>(
        listener: (context, state) {},
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                  appBar: const AppbarWidget(isHomepage: false),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Search movies',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                suffixIcon: TextButton.icon(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    WidgetsBinding
                                        .instance.focusManager.primaryFocus
                                        ?.unfocus();
                                    searchMovieBloc.add(
                                        GetSearchResultsMovieList(
                                            textController.text));
                                  },
                                  label: const Text('Search'),
                                )),
                          ),
                        ),
                        buildSearchResultsMovieList(context, searchMovieBloc)
                      ],
                    ),
                  ),
                  bottomNavigationBar: const BottomNavbar()),
            );
          },
        ),
      ),
    );
  }
}
