import 'package:flutter/material.dart';
import 'package:movie_app/navigation/routes.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomepage;
  const AppbarWidget({super.key, required this.isHomepage});

  @override
  Widget build(BuildContext context) {
    if (isHomepage) {
      return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Filip\'s Movie App',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchScreenRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      );
    } else {
      return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Filip\'s Movie App',
          ),
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
