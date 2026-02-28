
import 'package:ecommerce_clothing_store/screens/checkout_screen.dart';
import 'package:ecommerce_clothing_store/screens/favorites_screen.dart';
import 'package:ecommerce_clothing_store/screens/home_screen.dart';
import 'package:ecommerce_clothing_store/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CheckoutScreen(), // Using Checkout as Cart for now
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey[700],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              _buildNavItem(Icons.home_outlined, Icons.home, 0),
              _buildNavItem(Icons.shopping_bag_outlined, Icons.shopping_bag, 1),
              _buildNavItem(Icons.favorite_border, Icons.favorite, 2),
              _buildNavItem(Icons.person_outline, Icons.person, 3),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData unselectedIcon, IconData selectedIcon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(unselectedIcon),
      activeIcon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(selectedIcon),
          const SizedBox(height: 4),
          Container(
            height: 4,
            width: 4,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
      label: '',
    );
  }
}
