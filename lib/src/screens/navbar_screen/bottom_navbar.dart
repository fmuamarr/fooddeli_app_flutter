import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/data/notification/notification_helper.dart';
import 'package:dicoding_food_deli/src/screens/main_screen/favorite_screen.dart';
import 'package:dicoding_food_deli/src/screens/main_screen/home_screen.dart';
import 'package:dicoding_food_deli/src/screens/main_screen/profile_screen.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_item_detail.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  static const routeName = '/bottom_menu';

  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final List<Widget> _listPages = [
    const HomePageScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  final List<IconData> _selectedIcons = [
    Icons.home,
    Icons.collections_bookmark,
    Icons.person,
  ];

  final List<IconData> _unselectedIcons = [
    Icons.home_outlined,
    Icons.collections_bookmark_outlined,
    Icons.person_outline,
  ];

  final List<String> _labels = [
    'Home',
    'Favorites',
    'Profile',
  ];

  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        context, RestaurantDetailScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPages[_selectedNavbar],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: kBorderGreyColor),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: List.generate(_selectedIcons.length, (index) {
            return BottomNavigationBarItem(
              icon: AnimatedCrossFade(
                firstChild: Icon(
                  _unselectedIcons[index],
                  key: ValueKey("unselected$index"),
                ),
                secondChild: Icon(
                  _selectedIcons[index],
                  key: ValueKey("selected$index"),
                ),
                duration: const Duration(milliseconds: 300),
                crossFadeState: _selectedNavbar == index
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
              label: _labels[index],
            );
          }),
          currentIndex: _selectedNavbar,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kPrimaryColor.withOpacity(0.4),
          showUnselectedLabels: false,
          showSelectedLabels: true,
          elevation: 0,
          onTap: _changeSelectedNavBar,
        ),
      ),
    );
  }
}
