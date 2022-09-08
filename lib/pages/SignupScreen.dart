import 'package:dart_ipify/dart_ipify.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:style_buddy/models/GetMasterListModel.dart';
import 'package:style_buddy/models/SearchSalonAutoModel.dart';
import 'package:style_buddy/pages/LoginScreen.dart';
import 'package:style_buddy/providers/EmailAndMobileValidationProvider.dart';
import 'package:style_buddy/providers/GetMasterListProvider.dart';
import 'package:style_buddy/providers/RegistrationProvider.dart';
import 'package:style_buddy/providers/SearchSalonAutoProvider.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'package:style_buddy/utils/Config.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';
import 'package:style_buddy/utils/ConstantsURL.dart';
import 'package:style_buddy/utils/StylebuddyPreferences.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool agree = false;
  bool _isObscure = true;
  bool _conisObscure = true;
  bool isPrince = false;
  bool isPrincess = false;
  int avtar = 5;

  List<Body> entityNameList = [];
  List<dynamic> allSaloneList = [];
  List<dynamic> allSaloneListId = [];
  List<GetMasterBody> mastersList = [];

  List<dynamic> allMastersList = [];
  List<dynamic> allMastersListId = [];

  List<String> allSalons = [];
  List<String> allSalonsId = [];

  List<String> allMasters = [];
  List<String> allMastersId = [];
  var selectEntityName;
  var selectStyleMasterName;
  int? selectStyleMasterID;

  StylebuddyPreferences stylebuddyPreferences = StylebuddyPreferences();

  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController entityNameController = TextEditingController();
  TextEditingController salonController = TextEditingController();
  TextEditingController styleMasterListController = TextEditingController();

  GlobalKey<FormState> formValidationKey = GlobalKey<FormState>();
  String deviceId = '';
  String deviceMacAdd = '';
  String createdfrom = '';

  @override
  void initState() {
    getDeviceIp();
    getDeviceIDAndMac();
    // getMasterListApiCall();
    getPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xfff5f7fb),
          body: SingleChildScrollView(
              child: Form(
            key: formValidationKey,
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * (.09),
                    width: MediaQuery.of(context).size.width * (.89),
                    margin: EdgeInsets.only(left: 21, top: 30, right: 20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Don\'t have an account?',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Raleway-Bold',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff020325),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please Signup',
                            textAlign: TextAlign.start,
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
                    height: MediaQuery.of(context).size.height * (.03),
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
                          color: Color(0xffffc3e2),
                          child: Text("login".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          elevation: 0,
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width / 2.45,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33.0),
                          ),
                          color: Color(0xfffc62b2),
                          child: Text("signup".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (.05),
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
                                print('isPrince : $isPrince');
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
                                        child: Container(
                                          padding: EdgeInsets.only(left: 8),
                                          child: SvgPicture.asset(
                                            'assets/images/android/Login/Prince.svg',
                                            height: 58,
                                            fit: BoxFit.fill,
                                            alignment: Alignment.center,
                                          ),
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

                                print('isPrincess : $isPrincess');
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
                                        child: Container(
                                          padding: EdgeInsets.only(right: 8),
                                          child: SvgPicture.asset(
                                            'assets/images/android/Login/Princess.svg',
                                            height: 58,
                                            fit: BoxFit.fill,
                                            alignment: Alignment.center,
                                          ),
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (.02),
                  ),
                  Container(
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
                                  // offset: const Offset(0, 10),
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
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
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
                              onFieldSubmitted: (val) {
                                emailValidationApiCall();
                              },
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Email field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        textFromFieldLableWidget('Password'),
                        Container(
                          child: Padding(
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
                                textInputAction: TextInputAction.next,
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
                                    borderSide:
                                        BorderSide(color: Color(0xffC6C7E3)),
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
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Confirm Password'),
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
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: _conisObscure,
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
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  fontFamily: 'Raleway-Regular',
                                  fontSize: 16,
                                  color: Color(0xffC6C7E3),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: _contoggle,
                                  child: Icon(
                                    _conisObscure
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
                              controller: confirmPasswordController,
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Confirm Password field is required';
                                }
                                if (controller != passwordController.text)
                                  return 'Confirm Password is not same as your Password.';
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Your Name'),
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
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
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
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Your Name',
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
                              controller: userNameController,
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Username field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Mobile'),
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
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.dialpad,
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
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Mobile',
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
                              controller: mobileController,
                              onChanged: (val) {
                                if (val.length == 10) {
                                  mobileValidationApiCall();
                                }
                              },
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Mobile No. field is required';
                                } else {
                                  if (controller.length != 10)
                                    return 'Mobile Number must be of 10 digit';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Pincode'),
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
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.add_location_sharp,
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
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Pincode',
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
                              controller: pinCodeController,
                              validator: (controller) {
                                if (controller == null || controller.isEmpty) {
                                  return 'Pincode field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Entity Name'),
                        Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(33)),
                          margin: EdgeInsets.only(left: 25, right: 25),
                          child: EasyAutocomplete(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.home_work,
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
                                  borderSide:
                                      BorderSide(color: Color(0xffC6C7E3)),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffC6C7E3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                hintText: 'Entity Name',
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
                              inputTextStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blueColor,
                                  fontWeight: FontWeight.bold),
                              suggestionTextStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.headingTitleColor,
                                  fontWeight: FontWeight.bold),
                              suggestions: allSalons,
                              onChanged: (value) {
                                setState(() {
                                  allSalons.clear();
                                  // allSaloneListId.clear();
                                  allSaloneList.clear();
                                });
                                if (value.length > 2) {
                                  entityNameApiCall(value);
                                }
                                print('onChanged entityName: ${value.length}');
                              },
                              onSubmitted: (value) {
                                mastersList.clear();

                                getMasterListApiCall();
                                setState(() {
                                  selectEntityName = value;
                                  allSaloneList.clear();
                                  allSalons.clear();
                                });
                                print('selectEntityName: $selectEntityName');
                              }),
                        ),
                        //-
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.02),
                        ),
                        textFromFieldLableWidget('Stylemaster Name'),
                        Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Container(
                              padding: EdgeInsets.only(left: 15, right: 20),
                              width: width,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(33),
                                border: Border.all(
                                  color: Color(0xffC6C7E3),
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff26273D29),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text(
                                    'Stylemaster Name',
                                    style: TextStyle(
                                      fontFamily: 'Raleway-Regular',
                                      fontSize: 16,
                                      color: Color(0xffC6C7E3),
                                    ),
                                  ),
                                  elevation: 0,
                                  isExpanded: true,
                                  value: selectStyleMasterName,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppColor.blueColor,
                                      fontWeight: FontWeight.bold),
                                  items: mastersList.map((GetMasterBody value) {
                                    return DropdownMenuItem<String>(
                                      onTap: () {
                                        setState(() {
                                          selectStyleMasterID =
                                              value.stylemasterid;
                                        });

                                        print('value : $selectStyleMasterID');
                                      },
                                      value: value.username,
                                      child: Text(
                                        value.username.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Raleway-Regular',
                                          fontSize: 16,
                                          color: AppColor.blueColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  // onTap: () {
                                  //   showSearch(
                                  //       context: context,
                                  //       delegate:
                                  //           StyleMasterSearch(styleMasterList));
                                  // },
                                  onChanged: (val) {
                                    setState(() {
                                      selectStyleMasterName = val;
                                    });
                                  },
                                ),
                              ),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.005),
                        ),
                        Row(
                          children: [
                            Material(
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Checkbox(
                                  value: agree,
                                  onChanged: (value) {
                                    setState(() {
                                      agree = value ?? false;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: BorderSide(
                                    color: Color(0xffC6C7E3),
                                  ),
                                  activeColor: Color(0xff01519B),
                                  checkColor: Colors.white,
                                  tristate: false,
                                ),
                              ),
                            ),
                            Text('I accept ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Raleway-Regular',
                                    color: Color(0xffC6C7E3))),
                            Text('terms & conditions',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Raleway-Bold',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff01519B))),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * (.01),
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
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
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (agree) {
                                  //API function call
                                  userRegisterApiCall();
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please agree to terms and conditions");
                                }
                              }
                            },
                            child: Container(
                              child: Text(
                                "REGISTER ME".toUpperCase(),
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))),
    );
  }

  // Code for Search Salon
  customSearch() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffC6C7E3)),
            borderRadius: BorderRadius.circular(25),
            color: Colors.white),
        height: 250,
        child: ListView.builder(
            // itemCount: styleMasterList.length,
            itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Rajiv Menon",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff01519B),
                  ),
                ),
              ),
            ],
          );
        }),
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

//for password hide/show
  _toggle() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  //for confirm password hide/show
  _contoggle() {
    setState(() {
      _conisObscure = !_conisObscure;
    });
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

  getPlatform() {
    if (isAndroid == true) {
      setState(() {
        createdfrom = "android";
      });
    } else if (isIos == true) {
      setState(() {
        createdfrom = "ios";
      });
    }
  }

  //API call for email validation
  emailValidationApiCall() async {
    final emailAndMobileValidationProvider =
        Provider.of<EmailAndMobileValidationProvider>(context, listen: false);

    var body = {"emailid": emailIdController.text};

    print('reqPayload :- $body');

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await emailAndMobileValidationProvider
        .getPostEmailAndMobileValidationData(
            Config.strBaseURL + Config.envVariable + emailValidationURL, body);
    print("apiResponse :- $result");

    if (result.body.isavilable == true) {
      // mobileValidationApiCall();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "Your emailid is already registered.");
      emailIdController.clear();
    }
  }

  //API call for mobile validation
  mobileValidationApiCall() async {
    final emailAndMobileValidationProvider =
        Provider.of<EmailAndMobileValidationProvider>(context, listen: false);

    var body = {"mob_num": mobileController.text};

    print('reqPayload :- $body');

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await emailAndMobileValidationProvider
        .getPostEmailAndMobileValidationData(
            Config.strBaseURL + Config.envVariable + mobileValidationURL, body);
    print("apiResponse :- $result");

    if (result.body.isavilable == false) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Your mobile number is already registered.");
      mobileController.clear();
    }
  }

//API call function declare
  userRegisterApiCall() async {
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    if (isPrince == true) {
      avtar = 5;
    } else if (isPrincess == true) {
      avtar = 6;
    } else {
      avtar = avtar;
    }

    var body = {
      "avatar": avtar,
      "emailid": emailIdController.text,
      "password": passwordController.text,
      "username": userNameController.text,
      "mobile": mobileController.text,
      "pincode": pinCodeController.text,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp,
      "profileimgpath": "",
      "stylemasterid": selectStyleMasterID
    };
    print('reqPayload :- $body');

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await registerProvider.getPostRegisterData(
        Config.strBaseURL + Config.envVariable + styleBuddyRegistrationURL,
        body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Registration successfully");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  //EntityNameApiCall function declare

  entityNameApiCall(String salonPrefix) async {
    setState(() {
      allSalons.clear();
      //  allSaloneListId.clear();
      allSaloneList.clear();
    });
    final getEntityNameProvider =
        Provider.of<SearchSalonAutoProvider>(context, listen: false);

    var body = {"prefix": salonPrefix};
    print('reqPayload :- $body');

    // Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await getEntityNameProvider.getPostEntityNameData(
        Config.strBaseURL + Config.envVariable + getSearchSalonAutocompleteURL,
        body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      print("data : ${result.body}");

      entityNameList = result.body;

      for (var i = 0; i < entityNameList.length; i++) {
        setState(() {
          allSaloneList.add(entityNameList[i].entityName);
          allSaloneListId.add(entityNameList[i].entityID);
        });
      }
      setState(() {
        allSalons = List<String>.from(allSaloneList);
      });

      print('allSaloneList :$allSaloneListId');
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  getMasterListApiCall() async {
    final getStyleMasterListProvider =
        Provider.of<GetMasterListProvider>(context, listen: false);
    //  var entityid = allSaloneListId[0];
    var entityid = allSaloneListId[allSaloneListId.length - 1];
    print("entityid :- $entityid");

    var body = {"entityid": entityid};
    print('reqPayload :- $body');

    var result = await getStyleMasterListProvider.getPostMasterListData(
        Config.strBaseURL + Config.envVariable + getStyleMasterListURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      print("data : ${result.body}");

      //setState(() {
      mastersList = result.body;
      print('datas : ${mastersList[0].username}');
      print('length : ${mastersList.length}');
      //    });

      /*     for (var i = 0; i < mastersList.length; i++) {
        setState(() {
          allMastersList.add(mastersList[i].username);
          allMastersListId.add(mastersList[i].stylemasterid);
        });
      }
      setState(() {
        allMasters = List<String>.from(allMastersList);
      }); */

      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}
