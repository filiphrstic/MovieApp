part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final BottomNavbarItem bottomNavbarItem;
  final int index;

  const NavigationState(this.bottomNavbarItem, this.index);

  @override
  List<Object> get props => [bottomNavbarItem, index];
}
