import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/navigation/bottom_navbar/navigation_cubit.dart';
import 'package:movie_app/navigation/routes.dart';
import 'package:movie_app/utilities/themes.dart';
import 'navigation/router.dart' as router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        title: 'Movie App',
        theme: Themes.themeData,
        initialRoute: homeScreenRoute,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
