import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    await Future.delayed(const Duration(seconds: 8));

    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        hasSeenOnboarding ? '/login' : '/onboarding',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CachedNetworkImage(
        imageUrl: "https://idoxa9y.sufydely.com/saaa.png",
        placeholder:
            (context, url) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
        errorWidget:
            (context, url, error) =>
                const Center(child: Icon(Icons.error, color: Colors.red)),
        imageBuilder:
            (context, imageProvider) => Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  opacity: 0.7,
                ),
              ),
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double imageSize = constraints.maxWidth * 0.5;
                    return CachedNetworkImage(
                      imageUrl:
                          "http://idoxa9y.sufydely.com/reynmen_prev_ui.png",
                      placeholder:
                          (context, url) => const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                      errorWidget:
                          (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),
      ),
    );
  }
}
