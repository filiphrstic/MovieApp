import 'package:flutter/material.dart';
import 'package:movie_app/widgets/bottom_navbar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Filip\'s Movie App',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Favorites',
                // style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavbar());
  }
}
