import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/navigation/bottom_navbar/bottom_navbar_items.dart';
import 'package:movie_app/navigation/bottom_navbar/navigation_cubit.dart';
import 'package:movie_app/navigation/routes.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: state.index,
          onTap: (index) {
            if (index != state.index) {
              if (index == 0) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(BottomNavbarItem.homepage);
                Navigator.popAndPushNamed(context, homeScreenRoute);
              } else if (index == 1) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(BottomNavbarItem.favorites);
                Navigator.popAndPushNamed(context, favoritesScreenRoute);
              }
            }
          });
    });
  }
}
