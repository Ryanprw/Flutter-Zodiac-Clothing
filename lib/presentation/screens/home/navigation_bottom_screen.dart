import 'package:clothing_zodiac/presentation/screens/home/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:clothing_zodiac/controllers/navigation_controller.dart';
import 'package:clothing_zodiac/presentation/screens/home/home_screen.dart';
import 'package:clothing_zodiac/presentation/screens/home/cart_screen.dart';
import 'package:clothing_zodiac/presentation/screens/home/favorite_screen.dart';
import 'package:clothing_zodiac/presentation/screens/home/profile_screen.dart';

class NavigationBottomScreen extends StatelessWidget {
  final NavigationController navigationController = Get.put(
    NavigationController(),
  );

  final List<Widget> pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const CategoriesScreen(),
    CartScreen(),
    const ProfileScreen(),
  ];

  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.favorite_outline,
    Icons.grid_view,
    Icons.shopping_bag_outlined,
    Icons.person_outline,
  ];

  NavigationBottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[navigationController.pageIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AnimatedBottomNavigationBar(
              icons: iconList,
              activeIndex: navigationController.pageIndex.value,
              gapLocation: GapLocation.none,
              backgroundColor: Colors.transparent,
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              notchSmoothness: NotchSmoothness.softEdge,
              onTap: (index) => navigationController.changePage(index),
            ),
          ),
        ),
      ),
    );
  }
}
