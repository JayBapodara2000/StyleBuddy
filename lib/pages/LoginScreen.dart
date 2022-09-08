import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:style_buddy/pages/CustomerLandingScreen.dart';
import 'package:style_buddy/pages/SignupScreen.dart';
import 'package:style_buddy/providers/LoginProvider.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'package:style_buddy/utils/Config.dart';
import 'package:style_buddy/utils/ConstantsURL.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';
import 'package:style_buddy/utils/StylebuddyPreferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  bool isError = false;

  bool isPrince = false;
  bool isPrincess = false;

  StylebuddyPreferences stylebuddyPreferences = StylebuddyPreferences();

  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formValidationKey = GlobalKey<FormState>();
  String deviceId = '';
  String deviceMacAdd = '';

  @override
  void initState() {
    getDeviceIp();
    getDeviceIDAndMac();
    super.initState();
  }

  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xffF5F7FB),
        body: SingleChildScrollView(
          child: Container(
            height: height - MediaQuery.of(context).padding.top,
            width: width,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * (.11),
                      width: MediaQuery.of(context).size.width * (.4),
                      margin:
                          EdgeInsets.only(left: 112, top: 40.42, right: 112),
                      child: SvgPicture.asset(
                        'assets/images/android/Login/login_logo.svg',
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (.035),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * (.09),
                      width: MediaQuery.of(context).size.width * (.68),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              'Have an account?',
                              style: TextStyle(
                                fontFamily: 'Raleway-Bold',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff020325),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Login to Continue',
                              style: TextStyle(
                                fontFamily: 'Raleway-ExtraBold',
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff020325),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (.036),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33.0),
                        color: Color(0xffffc3e2),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            elevation: 0,
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width / 2.25,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.0),
                            ),
                            color: Color(0xfffc62b2),
                            child: Text("login".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()),
                              );
                            },
                            elevation: 0,
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width / 2.45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.0),
                            ),
                            color: Color(0xffffc3e2),
                            child: Text("signup".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    /*   SizedBox(
                      height: MediaQuery.of(context).size.height * (.035),
                    ),
                                   Container(
                      height: MediaQuery.of(context).size.height * (.14),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPrince = !isPrince;
                                  isPrincess = false;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    child: Column(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xffC6C7E3),
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(37.5)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff26273D29),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          child: Image.asset(
                                            'assets/images/android/Customer_Assets/Login/k1.png',
                                            fit: BoxFit.fill,
                                          ),
                                          radius: 37.5,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Prince',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway-Regular',
                                            color: Color(0xffa4a4a4),
                                          )),
                                    ]),
                                  ),
                                  Positioned(
                                      right: 0,
                                      child: Container(
                                        child: SvgPicture.asset(
                                          isPrince
                                              ? 'assets/images/android/Login/checked.svg'
                                              : 'assets/images/android/Login/unchecked.svg',
                                          width: 22,
                                          height: 22,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 31,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPrincess = !isPrincess;
                                  isPrince = false;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    child: Column(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xffC6C7E3),
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(37.5)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff26273D29),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          child: Image.asset(
                                            'assets/images/android/Customer_Assets/Login/k2.png',
                                            width: 31,
                                            height: 44,
                                          ),
                                          radius: 37.5,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Princess',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway-Regular',
                                            color: Color(0xffa4a4a4),
                                          )),
                                    ]),
                                  ),
                                  Positioned(
                                      right: 0,
                                      child: Container(
                                        child: SvgPicture.asset(
                                          isPrincess
                                              ? 'assets/images/android/Login/checked.svg'
                                              : 'assets/images/android/Login/unchecked.svg',
                                          width: 22,
                                          height: 22,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ]),
                    ), */
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.065,
                    ),
                    Form(
                      key: formValidationKey,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            textFromFieldLableWidget('Email'),
                            Padding(
                              padding: EdgeInsets.only(left: 25, right: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff26273D29),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppColor.blueColor,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Color(0xfffc62b2),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffC6C7E3),
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffC6C7E3),
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffC6C7E3),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    hintText: 'youremail@gmail.com',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Raleway-Regular',
                                      fontSize: 16,
                                      color: Color(0xffC6C7E3),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffffffff),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 14.0, top: 14.0),
                                  ),
                                  controller: emailIdController,
                                  validator: (controller) {
                                    if (controller == null ||
                                        controller.isEmpty) {
                                      return 'Email field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * (.02),
                            ),
                            textFromFieldLableWidget('Password'),
                            Padding(
                              padding: EdgeInsets.only(left: 25, right: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff26273D29),
                                      blurRadius: 6,
                                      // offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: _isObscure,
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppColor.blueColor,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Color(0xfffc62b2),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffC6C7E3),
                                        width: 0.0,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffC6C7E3),
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffC6C7E3),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Raleway-Regular',
                                      fontSize: 16,
                                      color: Color(0xffC6C7E3),
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: _toggle,
                                      child: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Color(0xffCCCCCC),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffffffff),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 14.0, top: 14.0),
                                  ),
                                  controller: passwordController,
                                  validator: (controller) {
                                    if (controller == null ||
                                        controller.isEmpty) {
                                      return 'Password field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),

                            Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(left: 10, right: 25),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Color(0xff01519B), fontSize: 16),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * (.1),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //BUTTON

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                        colors: [Color(0xff01519B), Color(0xffFC62B2)],
                      ),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        if (formValidationKey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          //API function call
                          userLoginApiCall();
                        } else {}
                      },
                      child: Container(
                        child: Text(
                          "LOGIN".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.23,
                            fontSize: 16,
                            fontFamily: 'Raleway-ExtraBold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFromFieldLableWidget(String title) {
    return Container(
      padding: EdgeInsets.only(left: 40, bottom: 4),
      child: Text(
        '$title',
        style: TextStyle(
            fontFamily: 'Raleway-Regular',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black38),
      ),
    );
  }
  getDeviceIp() async {
    deviceIp = await Ipify.ipv4();
  }

  getDeviceIDAndMac() async {
    await stylebuddyPreferences.getDeviceId().then((value) {
      setState(() {
        deviceId = value;
        print('deviceId  :$deviceId');
      });
    });

    await stylebuddyPreferences.getDeviceMac().then((value) {
      setState(() {
        deviceMacAdd = value;
        print('deviceMacAdd  :$deviceMacAdd');
      });
    });
  }

  _toggle() {
    setState(() {
      _isObscure = !_isObscure;
      print('isObscure : $_isObscure');
    });
  }

//API call function declare
  userLoginApiCall() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    var body = {
      "emailid": emailIdController.text,
      "password": passwordController.text,
      "devicemac": deviceMacAdd,
      "clientip": deviceIp
    };
    print('reqPayload :- $body');

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await loginProvider.getPostLoginData(
        Config.strBaseURL + Config.envVariable + loginURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Login successfully");
      //set if user is logeed.
      stylebuddyPreferences.setIsUserLogged(true);
      print("username : ${result.body[0].username}");
      stylebuddyPreferences.setUserId(result.body[0].userid);
      stylebuddyPreferences.setCustId(result.body[0].custid);
      stylebuddyPreferences.setToken(result.body[0].token);
      stylebuddyPreferences.setUsername(result.body[0].username);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerLandingScreen(),
          ));
      Loader.hide();
    } else if (result.statusCode == 403) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Enter Correct Password.");
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}
