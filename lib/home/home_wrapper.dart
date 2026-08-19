import 'package:flutter/material.dart';
import 'package:foodie/home/cart_screen.dart';
import 'package:foodie/home/home_screen.dart';
import 'package:foodie/home/profile_screen.dart';
import 'package:foodie/home/search_screen.dart';
import 'package:foodie/home/wishlist_screen.dart';
import 'package:foodie/utils/custom_nav.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     extendBody: true,
  //     body: IndexedStack(
  //       index: _selectedIndex,
  //       children: _screens,
  //     ),
  //     bottomNavigationBar: CustomBottomNav(
  //       currentIndex: _selectedIndex,
  //       onTap: (index) => setState(() => _selectedIndex = index),
  //     ),
  //   );
  // }
  
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),

        Positioned(
          left: 0,
          right: 0,
         bottom: -MediaQuery.of(context).viewInsets.bottom,
          child: CustomBottomNav(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ],
    ),
  );
}
}
