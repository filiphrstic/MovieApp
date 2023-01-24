import 'package:flutter/material.dart';
import 'package:movie_app/navigation/routes.dart';
import 'package:movie_app/screens/homepage.dart';
import 'package:movie_app/screens/undefined_route.dart';

Route generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // Homepage
    case homeScreenRoute:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
    // Any other undefined screen
    default:
      return MaterialPageRoute(builder: (context) => const UndefinedScreen());
  }
}
