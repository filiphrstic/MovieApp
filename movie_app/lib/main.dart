import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Movie App',
      theme: Themes.themeData,
      initialRoute: homeScreenRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}
