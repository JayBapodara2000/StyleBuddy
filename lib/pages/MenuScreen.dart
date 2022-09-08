import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style_buddy/pages/BookingCalendarViewScreen.dart';
import 'package:style_buddy/pages/EditProfile.dart';
import 'package:style_buddy/pages/LoginScreen.dart';
import 'package:style_buddy/utils/StylebuddyPreferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  StylebuddyPreferences stylebuddyPreferences = StylebuddyPreferences();
  String userName = '';
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff020325).withOpacity(0.9),
          ),
          child: BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Drawer(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 337, right: 10, top: 10, bottom: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/android/Menu/close.svg',
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 19,
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/android/Configure/profile_icon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$userName',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Raleway-Bold',
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfile(),
                                    ));

                                // getSMProfileDetailsAPICall();
                              },
                              child: Text(
                                'Edit Profile',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Raleway-Bold',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff5BB33E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height * .05,),
                  /*              avatar == 1 || avatar == 2
                      ? ListTile(
                          leading: Container(
                            padding: EdgeInsets.only(
                              left: 30,
                            ),
                            child: Text(
                              'Configure',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Raleway-SemiBold',
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                          trailing: Container(
                            child: SvgPicture.asset(
                              'assets/images/android/Menu/Icon ionic-ios-arrow-back.svg',
                            ),
                          ),
                          onTap: () {
              
                          },
                        )
                      : Container(), */
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'Manage Work Space',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Raleway-SemiBold',
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    trailing: Container(
                      child: SvgPicture.asset(
                        'assets/images/android/Menu/Icon ionic-ios-arrow-back.svg',
                      ),
                    ),
                    onTap: () => null,
                  ),
                  ListTile(
                      leading: Container(
                        width: 175,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                'Requests',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Raleway-SemiBold',
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            ClipOval(
                              child: Container(
                                color: Colors.red,
                                width: 13,
                                height: 13,
                                child: Center(
                                  child: Text(
                                    '8',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: Container(
                        child: SvgPicture.asset(
                          'assets/images/android/Menu/Icon ionic-ios-arrow-back.svg',
                        ),
                      ),
                      onTap: () {}),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'View All Appointment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Raleway-SemiBold',
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    trailing: Container(
                      child: SvgPicture.asset(
                        'assets/images/android/Menu/Icon ionic-ios-arrow-back.svg',
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BookingCalendarViewScreen()));
                    },
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'Setting',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Raleway-SemiBold',
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    trailing: Container(
                      child: SvgPicture.asset(
                        'assets/images/android/Menu/Icon ionic-ios-arrow-back.svg',
                      ),
                    ),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'Help',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Raleway-SemiBold',
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    trailing: Container(
                      child: SvgPicture.asset(
                        'assets/images/android/Menu/Icon ionic-ios-arrow-back.svg',
                      ),
                    ),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'Privacy & Terms',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Raleway-SemiBold',
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    trailing: Container(
                      child: SvgPicture.asset(
                        'assets/images/android/Menu/Icon ionic-ios-arrow-back.svg',
                      ),
                    ),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'App Version',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Raleway-SemiBold',
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    trailing: Container(
                      child: SvgPicture.asset(
                        'assets/images/android/Menu/Icon ionic-ios-arrow-back.svg',
                      ),
                    ),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        'Logout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Raleway-SemiBold',
                          color: Color(0xffFC62B2),
                        ),
                      ),
                    ),
                    trailing: Container(
                      child: SvgPicture.asset(
                        'assets/images/android/Menu/icon_logout.svg',
                      ),
                    ),
                    onTap: () {
                      stylebuddyPreferences.clearAllSharedPreferences();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getUserName() async {
    userName = await stylebuddyPreferences.getUsername();
    setState(() {});
    print('userName Data : $userName');
  }
}
