import 'package:flutter/material.dart';
import 'package:movie_app/navigation/routes.dart';
import 'package:movie_app/screens/favorites.dart';
import 'package:movie_app/screens/homepage.dart';
import 'package:movie_app/screens/undefined_route.dart';

Route generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // Homepage
    case homeScreenRoute:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
    // Favorites
    case favoritesScreenRoute:
      return MaterialPageRoute(builder: (context) => const FavoritesPage());
    // Any other undefined screen
    default:
      return MaterialPageRoute(builder: (context) => const UndefinedScreen());
  }
}
