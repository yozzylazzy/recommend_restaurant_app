import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/home_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return screenHeight >= 200 && screenWidth >= 200
        ? Scaffold(
            backgroundColor: Colors.brown,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fastfood_outlined,
                    size: screenHeight > screenWidth
                        ? (screenHeight / screenWidth) * 45
                        : (screenWidth / screenHeight) * 45,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Restaurant Recommendation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenHeight > screenWidth
                          ? (screenHeight / screenWidth) * 9
                          : (screenWidth / screenHeight) * 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: Text('Restaurant Recommendation'),
          );
  }
}
