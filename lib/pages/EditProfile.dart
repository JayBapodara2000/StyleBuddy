import 'dart:io';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:style_buddy/models/GetSBProfileDataModel.dart';
import 'package:style_buddy/providers/GetSBProfileDataProvider.dart';
import 'package:style_buddy/providers/UpdateProfileProvider.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'package:style_buddy/utils/Config.dart';
import 'package:style_buddy/utils/ConstantsURL.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';
import 'package:style_buddy/utils/StylebuddyPreferences.dart';
import 'package:url_launcher/url_launcher.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  List<dynamic> allCityList = [];
  List<dynamic> allCityListId = [];
  List<String> allCities = [];
  List<String> allCitiesId = [];
  //List<Body> cityNameList = [];

  GlobalKey<FormState> formValidationKey = GlobalKey<FormState>();
  int? styleMasterId;
  int? custId;
  String userName = '';
  String mobile = '';
  String email = '';
  String? latitude;
  String? longitude;

  List<BodyOfGetSBProfileData> getProfileDetails = [];

  StylebuddyPreferences stylebuddyPreferences = StylebuddyPreferences();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController styleMasterNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  //TextEditingController address2Controller = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController entityNameController = TextEditingController();
  TextEditingController latLongController = TextEditingController();

  @override
  void initState() {
    getCustId();
    //getStyleMasterId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void takePhoto(ImageSource source) async {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Color(0xffFFFFFF),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(38),
        )),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway-Bold',
            color: Color(0xff020325),
          ),
        ),
        leading: Container(
          padding: EdgeInsets.only(left: 24, top: 14, bottom: 14),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              'assets/images/android/Edit_Profile/back.svg',
              height: 36,
              width: 36,
              fit: BoxFit.scaleDown,
              color: Color(0xff01519B),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formValidationKey,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * (.153),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(38.0),
                      bottomRight: Radius.circular(38.0)),
                  color: Color(0xff01519B),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 14, bottom: 17),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xff01519B),
                            backgroundImage: _imageFile != null
                                ? FileImage(File(_imageFile!.path))
                                : AssetImage(
                                        'assets/images/android/Configure/profile_icon.png')
                                    as ImageProvider,
                          ),
                        ),
                        Positioned(
                          height: 24,
                          width: 24,
                          right: 0,
                          top: 25,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              takePhoto(ImageSource.camera);
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.camera,
                                                  ),
                                                  Text(
                                                    " Camera",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              takePhoto(ImageSource.gallery);
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.image,
                                                  ),
                                                  Text(
                                                    " Gallery",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ));
                                },
                              );
                            },
                            child: SvgPicture.asset(
                                'assets/images/android/Edit_Profile/upload_img.svg'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 28,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 43, bottom: 49),
                      child: Text(
                        getProfileDetails.length == 0 ||
                                getProfileDetails == null
                            ? ""
                            : '${getProfileDetails[0].username}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway-Bold',
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (.052),
              ),
              getProfileDetails.length == 0 || getProfileDetails == null
                  ? Container()
                  : userTextFields(getProfileDetails[0]),
              SizedBox(
                height: 10,
              ),
              Container(
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
                      updateProfileAPICall();
                    }
                  },
                  child: Container(
                    child: Text(
                      "Save".toUpperCase(),
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
        ),
      ),
    );
  }

  //Field visible when user is an admin
  userTextFields(BodyOfGetSBProfileData getProfileDetails) {
    if (getProfileDetails.username != null) {
      usernameController.text = getProfileDetails.username.toString();
    }
    if (getProfileDetails.emailID != null) {
      emailIdController.text = getProfileDetails.emailID.toString();
    }
    if (getProfileDetails.mobile != null) {
      mobileController.text = getProfileDetails.mobile.toString();
    }

    if (getProfileDetails.styleMasterName != null) {
      styleMasterNameController.text =
          getProfileDetails.styleMasterName.toString();
    }
    if (getProfileDetails.salonname != null) {
      entityNameController.text = getProfileDetails.salonname.toString();
    }

    if (getProfileDetails.address != null) {
      address1Controller.text = getProfileDetails.address.toString();
    }
    if (getProfileDetails.latitiude != null &&
        getProfileDetails.longitude != null) {
      latLongController.text = getProfileDetails.latitiude.toString() +
          getProfileDetails.longitude.toString();
    }

    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        textFromFieldLableWidget('Username'),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              autofocus: false,
              enabled: true,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: 'Username',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16.0,
                    color: Color(0xff01519B),
                    fontWeight: FontWeight.bold),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: usernameController,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (.02),
        ),
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
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
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
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: emailIdController,
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
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
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
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: mobileController,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (.02),
        ),
        textFromFieldLableWidget('StyleMaster name'),
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
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_add_rounded,
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: 'StyleMaster name',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16,
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: styleMasterNameController,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (.02),
        ),
        textFromFieldLableWidget('Entity name'),
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
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
                  fontWeight: FontWeight.bold),
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: 'Entity name',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16,
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: entityNameController,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (.02),
        ),
        textFromFieldLableWidget('Address'),
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
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on,
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C7E3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(33),
                ),
                hintText: 'Address',
                hintStyle: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    fontSize: 16,
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: address1Controller,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              autofocus: false,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff01519B),
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
                  borderSide: BorderSide(color: Color(0xffC6C7E3)),
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
                    color: Color(0xffC6C7E3)),
                filled: true,
                fillColor: Color(0xffffffff),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 14.0, top: 14.0),
              ),
              controller: pinCodeController,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (.02),
        ),
        textFromFieldLableWidget('Lat Long'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                String url =
                    'https://www.google.com/maps/dir/?api=$mapApiKey&origin=${position.latitude},${position.longitude}';

                goToGoogleMaps(url);
                latLongController.text =
                    "${position.latitude}, ${position.longitude}";

                setState(() {
                  latitude = position.latitude.toString();
                  longitude = position.longitude.toString();
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 25),
                decoration: BoxDecoration(
                    color: AppColor.blueColor, shape: BoxShape.circle),
                height: 42,
                width: 42,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Icon(
                  Icons.directions,
                  color: Color(0xfffc62b2),
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
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
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff01519B),
                      fontWeight: FontWeight.bold),
                  controller: latLongController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffC6C7E3),
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC6C7E3)),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffC6C7E3),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    hintText: 'Lat Long',
                    hintStyle: TextStyle(
                        fontFamily: 'Raleway-Regular',
                        fontSize: 16,
                        color: Color(0xffC6C7E3)),
                    filled: true,
                    fillColor: Color(0xffffffff),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 14.0, top: 14.0),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
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

/*   getStyleMasterId() async {
    await stylebuddyPreferences.getstylemasterid().then((value) {
      setState(() {
        styleMasterId = value;
        print('StyleMaster  :$styleMasterId');
        getSBProfileDetailsAPICall();
      });
    });
  } */

  getCustId() async {
    await stylebuddyPreferences.getCustId().then((value) {
      setState(() {
        custId = value;
        print('custId  :$custId');
        getSBProfileDetailsAPICall();
      });
    });
  }

  goToGoogleMaps(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getSBProfileDetailsAPICall() async {
    final getSBProfileDetailsProvider =
        Provider.of<GetSBProfileDataProvider>(context, listen: false);

    var body = {"custid": 3};

    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    var result = await getSBProfileDetailsProvider.getPostSBprofiledata(
        Config.strBaseURL + Config.envVariable + sbProfileDataURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      setState(() {
        getProfileDetails = result.body;
        print('getProfileDetails : $getProfileDetails');
      });

      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

/*   getCityAutoApiCall(String cityPrefix) async {
    setState(() {
      allCities.clear();
      //  allCityListId.clear();
      allCityList.clear();
    });
    final getCityAutoProvider =
        Provider.of<GetCityAutoProvider>(context, listen: false);

    var body = {"prefix": cityPrefix};
    print('reqPayload :- $body');

    // Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await getCityAutoProvider.getPostGetCityAutoData(
        Config.strBaseURL + Config.envVariable + getCityAutoURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      print("data : ${result.body}");

      cityNameList = result.body;

      for (var i = 0; i < cityNameList.length; i++) {
        setState(() {
          allCityList.add(cityNameList[i].city);
          allCityListId.add(cityNameList[i].cityID);
        });
      }
      setState(() {
        allCities = List<String>.from(allCityList);
      });

      print('allCityList :$allCityListId');
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
 */
  //api call to update profile of stylemaster
  updateProfileAPICall() async {
    final updateProfileProvider =
        Provider.of<UpdateProfileProvider>(context, listen: false);

    var body = {
      "custid": custId,
      "emailid": emailIdController.text,
      "mobile": mobileController.text,
      "stylemasterid": 0
    };

    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    var result = await updateProfileProvider.getPostUpdateProfileData(
        Config.strBaseURL + Config.envVariable + updateprofileURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Stylemaster Profile Updated successfully");
      Navigator.of(context).pop();
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}
