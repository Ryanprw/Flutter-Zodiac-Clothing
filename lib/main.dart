import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clothing_zodiac/controllers/cart_controller.dart';
import 'package:clothing_zodiac/presentation/screens/home/detail_screen.dart';
import 'package:clothing_zodiac/presentation/screens/home/navigation_bottom_screen.dart';
import 'package:clothing_zodiac/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:clothing_zodiac/presentation/screens/splashscreen/splash_screen.dart';
import 'package:clothing_zodiac/presentation/screens/auth/login_screen.dart';

void main() {
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clothing ZODIAC',
      theme: ThemeData(primaryColor: const Color(0xFFEF6969)),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => const OnboardingPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/home', page: () => NavigationBottomScreen()),
        GetPage(
          name: '/productDetail',
          page:
              () => ProductDetailScreen(
                product: Get.arguments as Map<String, dynamic>,
              ),
        ),
      ],
    );
  }
}
