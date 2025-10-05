import 'package:flutter/material.dart';
import 'package:medi_admin_app/screens/AddProductScreen.dart';
import 'package:medi_admin_app/screens/GetAllOrdersScreen.dart';
import 'package:medi_admin_app/screens/GetAllUsersScreen.dart';
import 'package:medi_admin_app/screens/OrderDetailsScreen.dart';
import 'package:medi_admin_app/viewModel/MyViewModel.dart';
import 'package:provider/provider.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';


void main() {
  runApp(ChangeNotifierProvider(create: (_) => MyViewModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BottomNavBar());
  }
}


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PageController _pageController = PageController();
  final NotchBottomBarController _notchController = NotchBottomBarController(index: 0);

  final List<Widget> _screens = [
    AddProductScreen(),
    GetAllOrdersScreen(),
    GetAllUsersScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _notchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100, // soft light background
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent.shade100,
              Colors.lightBlueAccent.shade200,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlueAccent.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: AnimatedNotchBottomBar(
          notchBottomBarController: _notchController,
          kBottomRadius: 18,
          kIconSize: 28,
          color: Colors.lightBlueAccent.shade100, // base background
          notchColor: Colors.lightBlueAccent.shade200, // notch highlight
          showLabel: true,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: const Icon(Icons.add_box_outlined, color: Colors.white70),
              activeItem: const Icon(Icons.add_box_rounded, color: Colors.white),
              itemLabel: 'Add Products',

            ),
            BottomBarItem(
              inActiveItem: const Icon(Icons.inventory_2_outlined, color: Colors.white70),
              activeItem: const Icon(Icons.inventory_2_rounded, color: Colors.white),
              itemLabel: 'All Orders',

            ),
            BottomBarItem(
              inActiveItem: const Icon(Icons.person_outline, color: Colors.white70),
              activeItem: const Icon(Icons.person, color: Colors.white),
              itemLabel: 'All Users',

            ),
          ],
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
