import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:style_buddy/models/GetMyStyleMasterModel.dart';
import 'package:style_buddy/models/GetRecommendedSalonModel.dart';
import 'package:style_buddy/pages/CustomerBookingSlotScreen.dart';
import 'package:style_buddy/pages/CustomerSearchingScreen.dart';
import 'package:style_buddy/pages/MenuScreen.dart';
import 'package:style_buddy/providers/GetMyStyleMasterProvider.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'package:style_buddy/utils/Config.dart';
import 'package:style_buddy/utils/ConstantsURL.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';
import 'package:style_buddy/utils/ConstantsStyle.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:style_buddy/utils/StylebuddyPreferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../providers/GetRecommendedSalonProvider.dart';

class CustomerLandingScreen extends StatefulWidget {
  @override
  _CustomerLandingScreenState createState() => _CustomerLandingScreenState();
}

class _CustomerLandingScreenState extends State<CustomerLandingScreen> {
  List<String> _locationsList = [
    'Miyapur, Allwyn colony',
    'Any',
    'A1',
    'B2',
    'D'
  ];
  final _formKey = GlobalKey<FormState>();
  //late final int styleMasterId;
  //late final int coStyleMasterId;
  List<String> styleMastersList = ["0", "1", "2", "3"];

  int _currentItem = 0;
  int _currentItem1 = 0;
  int custId = 0;
  String countryName = '';
  String cityName = '';
  double latitudes = 0;
  double longitudes = 0;

  StylebuddyPreferences stylebuddyPreferences = StylebuddyPreferences();

  List<Body> crazyStyleMastersListData = [];
  List<Body> coStyleMastersListData = [];
  List<BodyRS> recommendedSalonListData = [];
  bool isLoading = true;

  @override
  void initState() {
    getUserInfo();
    getCountry();
    getCityName();
    getLatLng();

    super.initState();
  }

  @override
  void dispose() {
    Loader.hide();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColor.blueColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          toolbarHeight: 65,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(38),
          )),
          centerTitle: true,
          title: Text(
            'Salons',
            textAlign: TextAlign.center,
            style: appBarTextStyle,
          ),
          leading: Container(
            padding: EdgeInsets.only(left: 24, top: 14, bottom: 14),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
              child: SvgPicture.asset(
                'assets/images/android/Customer_Assets/Landing/menu.svg',
                height: 36,
                width: 36,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 12, top: 0, bottom: 0),
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/android/Customer_Assets/Landing/UserProfile.png',
                  height: 46,
                  width: 46,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'assets/images/android/Customer_Assets/Landing/map.png'))),
                height: height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    locationBox(),
                    styleMastersDetails(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget locationBox() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height * 0.23,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColor.lightBlueColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SizedBox(
                  // width: width / 1.4,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: AppColor.blueColor,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: Text(
                          '$countryName',
                          style: TextStyle(
                              color: AppColor.blueColor,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  /*       child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                        hintText: 'Miyapur, Allwyn colony',
                        hintStyle: TextStyle(
                            color: AppColor.blueColor,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.location_pin,
                          color: AppColor.blueColor,
                        )
                        /*     prefixIcon: Image(
                            image:
                                AssetImage('assets/images/android/location.png')), */
                        ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColor.blueColor,
                    ),
                    items: _locationsList.map((var value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(
                          value,
                          style: TextStyle(
                              color: AppColor.blueColor,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      print(val);
                    },
                  ), */
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerSearchingScreen(
                            currentAddress: countryName)),
                  );
                },
                child: Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(blurRadius: 12, color: Colors.black12)
                  ]),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      enabled: false,
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Find a Salon, Services, Style Master...',
                        hintStyle: TextStyle(
                            color: AppColor.textBoxBorderColor,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.textBoxBorderColor,
                        ),
                        fillColor: AppColor.whiteColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.textBoxBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(33),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.textBoxBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(33),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.textBoxBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(33),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.textBoxBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(33),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.textBoxBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(33),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget styleMastersDetails() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Flexible(
      child: Container(
        // height: height - 280,
        //width: width,
        decoration: BoxDecoration(
            color: AppColor.lightGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 36,
                ),
                headingTitle("Your Crazy Style Masters"),
                /*      SizedBox(
                  height: 15,
                ), */
                crazyStyleMastersListData.length == 0
                    ? Container(
                        height: 140,
                        child: Center(
                          child: Text(
                            'No Crazy Style Masters Found',
                            style: TextStyle(
                                color: AppColor.headingTitleColor,
                                fontFamily: 'Raleway',
                                fontSize: 16),
                          ),
                        ),
                      )
                    : crazyStyleMastersListFunction(),
                crazyStyleMastersListData.length == 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        child: Center(
                          child: DotsIndicator(
                            dotsCount: crazyStyleMastersListData.length,
                            position: double.parse("$_currentItem"),
                            decorator: DotsDecorator(
                              activeColor: AppColor.blueColor,
                              spacing: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 8),
                              color: Color(0xffD8D8D8),
                              size: const Size.square(9.0),
                              activeSize: const Size(21.0, 9.0),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ),
                headingTitle('Co Style Masters'),
                /*      SizedBox(
                  height: 15,
                ), */
                coStyleMastersListData.length == 0
                    ? Container(
                        height: 140,
                        child: Center(
                          child: Text(
                            'No Co Style Masters Found',
                            style: TextStyle(
                                color: AppColor.headingTitleColor,
                                fontFamily: 'Raleway',
                                fontSize: 16),
                          ),
                        ),
                      )
                    : coStyleMastersListFunction(),
                coStyleMastersListData.length == 0
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 4),
                        child: Center(
                          child: DotsIndicator(
                            dotsCount: coStyleMastersListData.length,
                            position: double.parse("$_currentItem1"),
                            decorator: DotsDecorator(
                              activeColor: AppColor.blueColor,
                              spacing: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 8),
                              color: Color(0xffD8D8D8),
                              size: const Size.square(9.0),
                              activeSize: const Size(21.0, 9.0),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ),
                headingTitle('Recommended Salons'),
                SizedBox(
                  height: 10,
                ),
                recommendedSalonsList(),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget crazyStyleMastersListFunction() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: 140,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: crazyStyleMastersListData.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, i) {
            return VisibilityDetector(
              key: Key(i.toString()),
              onVisibilityChanged: (VisibilityInfo info) {
                if (info.visibleFraction == 1)
                  setState(() {
                    _currentItem = i;
                    print(_currentItem);
                  });
              },
              child: Stack(
                //clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 7, right: 7, top: 18),
                    padding: EdgeInsets.only(left: 20, top: 12, bottom: 0),
                    decoration: BoxDecoration(
                        color: i % 2 == 0
                            ? AppColor.blueColor
                            : AppColor.lightPinkColor,
                        borderRadius: BorderRadius.circular(10)),
                    height: 140,
                    width: width * 0.65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${crazyStyleMastersListData[i].name}",
                              style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${crazyStyleMastersListData[i].entname}",
                              style: TextStyle(
                                  color: AppColor.textBoxBorderColor,
                                  fontFamily: 'Raleway',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.star,
                                color: AppColor.whiteColor,
                                size: 15,
                              )),
                              TextSpan(
                                  text:
                                      " ${crazyStyleMastersListData[i].rating}",
                                  style: TextStyle(
                                      color: AppColor.ratingTextColor,
                                      fontFamily: 'Raleway',
                                      fontSize: 14))
                            ])),
                            MaterialButton(
                                color: AppColor.whiteColor,
                                elevation: 0,
                                height: 22,
                                minWidth: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)),
                                onPressed: () {
                                  //styleMasterId = crazyStyleMastersListData[i].stylemasterid!;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerBookingSlotScreen(
                                                value:
                                                    crazyStyleMastersListData[i]
                                                        .stylemasterid!)),
                                  );
                                },
                                child: Text(
                                  'Book',
                                  style: TextStyle(
                                      color: AppColor.blueColor,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  crazyStyleMastersListData[i].avatar == "1"
                      ? Positioned(
                          //top: -36,
                          bottom: 0,
                          right: -40,
                          child: Container(
                              child: SvgPicture.asset(
                            'assets/images/android/Customer_Assets/Landing/styleMaster.svg',
                            height: 156,
                            fit: BoxFit.cover,
                          )),
                        )
                      : Positioned(
                          //top: -36,
                          bottom: 0,
                          right: -80,
                          child: Container(
                              child: Image.asset(
                            'assets/images/android/Customer_Assets/Landing/co_stylemaster.png',
                            height: 142,
                            fit: BoxFit.cover,
                          )),
                        )
                  /*(crazyStyleMastersListData[i].avatar == 1 || crazyStyleMastersListData[i].avatar == 3) ?
                    Positioned(
                      //top: -36,
                      bottom: 0,
                      right: -40,
                      child: Container(
                          child: SvgPicture.asset(
                        'assets/images/android/Customer_Assets/Landing/styleMaster.svg' ,
                        height: 156,
                        fit: BoxFit.cover,
                      )),
                    ) :
                  Positioned(
                    //top: -36,
                    bottom: 0,
                    right: -80,
                    child: Container(
                      child: Image.asset(
                        'assets/images/android/Customer_Assets/Landing/co_stylemaster.png',
                        height: 142,
                        fit: BoxFit.cover,
                    )),
                  ),*/
                ],
              ),
            );
          }),
    );
  }

  Widget coStyleMastersListFunction() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: 140,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: coStyleMastersListData.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, i) {
            return VisibilityDetector(
              key: Key(i.toString()),
              onVisibilityChanged: (VisibilityInfo info) {
                if (info.visibleFraction == 1)
                  setState(() {
                    _currentItem1 = i;
                    print(_currentItem1);
                  });
              },
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 0),
                    margin: EdgeInsets.only(left: 7, right: 7, top: 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: AppColor.textBoxBorderColor),
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    height: 140,
                    width: width * 0.65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${coStyleMastersListData[i].name}",
                              style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${coStyleMastersListData[i].entname}",
                              style: TextStyle(
                                  color: AppColor.textBoxBorderColor,
                                  fontFamily: 'Raleway',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.star,
                                color: AppColor.blueColor,
                                size: 15,
                              )),
                              TextSpan(
                                  text: " ${coStyleMastersListData[i].rating}",
                                  style: TextStyle(
                                      color: AppColor.blackColor,
                                      fontFamily: 'Raleway',
                                      fontSize: 14))
                            ])),
                            MaterialButton(
                                color: AppColor.blueColor,
                                elevation: 0,
                                height: 22,
                                minWidth: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)),
                                onPressed: () {
                                  //coStyleMasterId = coStyleMastersListData[i].stylemasterid!;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerBookingSlotScreen(
                                                value: coStyleMastersListData[i]
                                                    .stylemasterid!)),
                                  );
                                },
                                child: Text(
                                  'Book',
                                  style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  coStyleMastersListData[i].avatar == "1"
                      ? Positioned(
                          //top: -36,
                          bottom: 0,
                          right: -40,
                          child: Container(
                              child: SvgPicture.asset(
                            'assets/images/android/Customer_Assets/Landing/styleMaster.svg',
                            height: 156,
                            fit: BoxFit.cover,
                          )),
                        )
                      : Positioned(
                          //top: -36,
                          bottom: 0,
                          right: -80,
                          child: Container(
                              child: Image.asset(
                            'assets/images/android/Customer_Assets/Landing/co_stylemaster.png',
                            height: 142,
                            fit: BoxFit.cover,
                          )),
                        )

                  /*(crazyStyleMastersListData[i].avatar == 1 || crazyStyleMastersListData[i].avatar == 3) ?
                  Positioned(
                    //top: -36,
                    bottom: 0,
                    right: -40,
                    child: Container(
                        child: SvgPicture.asset(
                          'assets/images/android/Customer_Assets/Landing/styleMaster.svg' ,
                          height: 156,
                          fit: BoxFit.cover,
                        )),
                  ) :
                  Positioned(
                    //top: -36,
                    bottom: 0,
                    right: -80,
                    child: Container(
                        child: Image.asset(
                      'assets/images/android/Customer_Assets/Landing/co_stylemaster.png',
                      height: 142,
                      fit: BoxFit.cover,
                    )),
                  ),*/
                ],
              ),
            );
          }),
    );
  }

  Widget recommendedSalonsList() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendedSalonListData.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, i) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15, top: 10, bottom: 0),
                  margin: EdgeInsets.only(left: 7, right: 7),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: AppColor.textBoxBorderColor),
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  height: 120,
                  width: width * 0.65,
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14, top: 4),
                        child: Container(
                          child: Image.asset(
                              'assets/images/android/Customer_Assets/Landing/recommended_1.png',
                              //    height: 156,
                              fit: BoxFit.cover),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${recommendedSalonListData[i].entityName}',
                                style: TextStyle(
                                    color: AppColor.blackColor,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Miyapur',
                                style: TextStyle(
                                    color: AppColor.textBoxBorderColor,
                                    fontFamily: 'Raleway',
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.star,
                                      color: AppColor.blueColor,
                                      size: 15,
                                    )),
                                    TextSpan(
                                        text:
                                            ' ${recommendedSalonListData[i].ratings}',
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontFamily: 'Raleway',
                                            fontSize: 14))
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.add_road_outlined,
                                      color: AppColor.blueColor,
                                      size: 15,
                                    )),
                                    TextSpan(
                                        text:
                                            ' ${recommendedSalonListData[i].distance} km',
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontFamily: 'Raleway',
                                            fontSize: 14))
                                  ])),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget headingTitle(String title) {
    return Container(
      child: Text(
        '$title',
        style: TextStyle(
            color: AppColor.headingTitleColor,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }

  getUserInfo() async {
    custId = await stylebuddyPreferences.getCustId();
    getMyStyleMasterApiCall();
  }

  getCityName() async {
    cityName = await stylebuddyPreferences.getCityName();
    print("city : $cityName");
  }

  getLatLng() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudes = position.latitude;
      longitudes = position.longitude;
    });
    print('lat: $latitudes -- long: $longitudes');
    getRecommendedSalonApiCall();
  }

  getCountry() async {
    countryName = await stylebuddyPreferences.getCurrentAdd();

    print('countryName Data : $countryName');
  }

//API call function declare
  Future<void> getMyStyleMasterApiCall() async {
    setState(() {
      isLoading = true;
    });
    final getMyStyleMasterProvider =
        Provider.of<GetMyStyleMasterProvider>(context, listen: false);

    var body = {"custid": custId};

    print('reqPayload :- $body');

    //   Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await getMyStyleMasterProvider.getPostGetMyStyleMasterData(
        Config.strBaseURL + Config.envVariable + getMyStyleMasterURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      for (var i = 0; i < result.body.length; i++) {
        if (result.body[i].flag == 1) {
          setState(() {
            crazyStyleMastersListData.add(result.body[i]);
          });
        } else {
          setState(() {
            coStyleMastersListData.add(result.body[i]);
          });
        }
      }
      setState(() {
        isLoading = false;
      });
      Loader.hide();
    } else {
      setState(() {
        isLoading = false;
      });
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  //API call function declare
  Future<void> getRecommendedSalonApiCall() async {
    setState(() {
      isLoading = true;
    });
    final getRecommendedSalonProvider =
        Provider.of<GetRecommendedSalonProvider>(context, listen: false);

    print("custid : $custId");
    var body = {
      "custid": custId,
      "city": 2,
      "lat": latitudes.toString(),
      "long": longitudes.toString()
    };

    print('reqPayload :- $body');

    //   Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result =
        await getRecommendedSalonProvider.getPostGetRecommendedSalonData(
            Config.strBaseURL + Config.envVariable + recommendedSalonURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      for (var i = 0; i < result.body.length; i++) {
        setState(() {
          recommendedSalonListData.add(result.body[i]);
        });
      }
      setState(() {
        isLoading = false;
      });
      Loader.hide();
    } else {
      setState(() {
        isLoading = false;
      });
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}
