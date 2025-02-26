import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clothing_zodiac/presentation/screens/auth/login_screen.dart';
import 'package:clothing_zodiac/presentation/widgets/image_card.dart';
import 'package:clothing_zodiac/presentation/widgets/get_started_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasOnboarded = prefs.getBool('hasOnboarded') ?? false;

    if (hasOnboarded) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'ZODIAC',
                        style: GoogleFonts.montserrat(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 3.0,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.6,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 0,
                              left: screenSize.width * 0.05,
                              child: const ImageCard(
                                imageUrl:
                                    'http://idoxa9y.sufydely.com/heel.png',
                                width: 200,
                                height: 250,
                              ),
                            ),
                            Positioned(
                              top: screenSize.height * 0.1,
                              right: screenSize.width * 0.05,
                              child: const ImageCard(
                                imageUrl:
                                    'http://idoxa9y.sufydely.com/zodiacB.png',
                                width: 200,
                                height: 250,
                              ),
                            ),
                            Positioned(
                              bottom: -10,
                              left: screenSize.width * 0.2,
                              child: const ImageCard(
                                imageUrl:
                                    'http://idoxa9y.sufydely.com/zodiacA.png',
                                width: 220,
                                height: 270,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Find your perfect style with our wide\nrange of clothing options!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      const GetStartedButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
