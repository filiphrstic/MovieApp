import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/navigation/bottom_navbar/bottom_navbar_items.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(const NavigationState(BottomNavbarItem.homepage, 0));

  void getNavBarItem(BottomNavbarItem bottomNavbarItem) {
    switch (bottomNavbarItem) {
      case BottomNavbarItem.homepage:
        emit(const NavigationState(BottomNavbarItem.homepage, 0));
        break;
      case BottomNavbarItem.favorites:
        emit(const NavigationState(BottomNavbarItem.favorites, 1));
        break;
    }
  }
}
