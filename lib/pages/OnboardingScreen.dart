import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style_buddy/pages/LoginScreen.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 10,
      width: isActive ? 22.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff01519B) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Container(
                        color: Color(0xffFFF7FB),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: height * 0.1,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: SvgPicture.asset(
                                  'assets/images/android/Onboarding/onboarding1.svg',
                                  height: height * 0.34,
                                  width: width,
                                  fit: BoxFit.cover,
                                  // height: 276.73,
                                  // width: 215.64,
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                              Center(
                                child: Text(
                                  'Helping you to take',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Raleway-Regular',
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'good care of your Hair',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Raleway-Bold',
                                    color: Color(0xffFC62B2),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Center(
                                child: Text(
                                  'Be your own kind of beautiful and create\na new look',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Raleway-Regular',
                                    color: Color(0xffA4A4A4),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _buildPageIndicator(),
                              ),
                              Spacer(),
                              SizedBox(
                                height: height * 0.018,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()));
                                        },
                                        child: Text(
                                          'Skip',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontFamily: 'Raleway-Medium',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      padding: EdgeInsets.only(right: 20),
                                      child: Container(
                                        width: 143,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [0.0, 1.0],
                                            colors: [
                                              Color(0xff01519B),
                                              Color(0xffFC62B2)
                                            ],
                                          ),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            _pageController.nextPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Next'.toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontFamily:
                                                        'Raleway-ExtraBold',
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 3.23),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 23.29,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffF0F8FF),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: height * 0.1,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: SvgPicture.asset(
                                  'assets/images/android/Onboarding/onboarding2.svg',
                                  height: height * 0.34,
                                  width: width,
                                  fit: BoxFit.cover,
                                  // height: 242.34,
                                  // width: 218.95,
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                              Center(
                                child: Text(
                                  'Discover and Book',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Raleway-Bold',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff01519B),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'your favourite Stylist',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Raleway-Regular',
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Center(
                                child: Text(
                                  'Schedule your appointment as per your\nconvenience',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Raleway-Regular',
                                    color: Color(0xffA4A4A4),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _buildPageIndicator(),
                              ),
                              Spacer(),
                              SizedBox(
                                height: height * 0.018,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()));
                                        },
                                        child: Text(
                                          'Skip',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontFamily: 'Raleway-Medium',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      padding: EdgeInsets.only(right: 20),
                                      child: Container(
                                        width: 143,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [0.0, 1.0],
                                            colors: [
                                              Color(0xff01519B),
                                              Color(0xffFC62B2)
                                            ],
                                          ),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            _pageController.nextPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Next'.toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontFamily:
                                                        'Raleway-ExtraBold',
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 3.23),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 23.29,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffFFF7FB),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.only(top: height * 0.1, left: 40),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/android/Onboarding/onboarding3.svg',
                                  height: height * 0.34,
                                  width: width,
                                  fit: BoxFit.cover,

                                  // height: 276.73,
                                  // width: 215.64,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.04),
                            Center(
                              child: Text(
                                'Share your new ',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Raleway-Regular',
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Text(
                                    'look and ',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Raleway-Regular',
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Text(
                                  'get rewards',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Raleway-Bold',
                                    color: Color(0xffFC62B2),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            Center(
                              child: Text(
                                'Share your look with your friends and\nearn reward points',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Raleway-Regular',
                                  color: Color(0xffA4A4A4),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildPageIndicator(),
                            ),
                            Spacer(),
                            SizedBox(
                              height: height * 0.018,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.0, 1.0],
                                    colors: [
                                      Color(0xff01519B),
                                      Color(0xffFC62B2)
                                    ],
                                  ),
                                ),
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "GET STARTED",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16,
                                            letterSpacing: 3.23,
                                            fontFamily: 'Raleway-ExtraBold',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.arrow_right_alt,
                                            color: Colors.white,
                                            size: 23.29,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
