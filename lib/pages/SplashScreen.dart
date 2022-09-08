import 'dart:async';
import 'package:flutter/material.dart';
import 'package:style_buddy/pages/CustomerLandingScreen.dart';
import 'package:style_buddy/pages/OnboardingScreen.dart';
import 'package:style_buddy/utils/StylebuddyPreferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StylebuddyPreferences stylebuddyPreferences = StylebuddyPreferences();
  bool isLogeed = false;

  @override
  void initState() {
    getUserData();
    Timer(Duration(seconds: 2), () {
      if (isLogeed) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CustomerLandingScreen()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => OnboardingScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      AssetImage('assets/images/android/Splash/Splash.png'))),
        ),
      ),
    );
  }

  getUserData() async {
    isLogeed = await stylebuddyPreferences.getIsUserLogged();
  }
}
