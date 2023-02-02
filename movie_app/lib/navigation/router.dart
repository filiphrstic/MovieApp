import 'package:flutter/material.dart';
import 'package:movie_app/navigation/routes.dart';
import 'package:movie_app/screen_arguments/chosen_movie.dart';
import 'package:movie_app/screens/favorites.dart';
import 'package:movie_app/screens/homepage.dart';
import 'package:movie_app/screens/movie_details.dart';
import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/screens/undefined_route.dart';

Route generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // Homepage
    case homeScreenRoute:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
    // Favorites
    case favoritesScreenRoute:
      return MaterialPageRoute(builder: (context) => const FavoritesPage());
    // Movie details
    case movieDetailsScreenRoute:
      ChosenMovie chosenMovieArgument = routeSettings.arguments as ChosenMovie;
      return MaterialPageRoute(
          builder: (context) =>
              MovieDetailsPage(chosenMovie: chosenMovieArgument));
    // Search
    case searchScreenRoute:
      return MaterialPageRoute(builder: (context) => const SearchPage());
    // Any other undefined screen
    default:
      return MaterialPageRoute(builder: (context) => const UndefinedScreen());
  }
}
