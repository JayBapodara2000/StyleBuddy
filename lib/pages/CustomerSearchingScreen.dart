import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:style_buddy/models/SearchSalonAutoModel.dart';
import 'package:style_buddy/pages/MenuScreen.dart';
import 'package:style_buddy/providers/SearchSalonAutoProvider.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'package:style_buddy/utils/Config.dart';
import 'package:style_buddy/utils/ConstantsURL.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';
import 'package:style_buddy/utils/ConstantsStyle.dart';

import '../models/GetRecommendedSalonModel.dart';
import '../providers/GetRecommendedSalonProvider.dart';
import '../utils/StylebuddyPreferences.dart';

class CustomerSearchingScreen extends StatefulWidget {
  final currentAddress;

  const CustomerSearchingScreen({Key? key, this.currentAddress})
      : super(key: key);
  @override
  _CustomerSearchingScreenState createState() =>
      _CustomerSearchingScreenState();
}

class _CustomerSearchingScreenState extends State<CustomerSearchingScreen> {
  List<String> _locationsList = [
    'Miyapur, Allwyn colony',
    'Any',
    'A1',
    'B2',
    'D'
  ];

  int custId = 0;
  String cityName = '';
  double latitudes = 0;
  double longitudes = 0;

  StylebuddyPreferences stylebuddyPreferences = StylebuddyPreferences();
  List<Body> salonNameList = [];
  List<BodyRS> recommendedSalonListData = [];
  bool isLoading = true;
  var selectsalonName;
  final _formKey = GlobalKey<FormState>();

  TextEditingController findSalonController = TextEditingController();

  @override
  void initState() {
    getUserInfo();
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
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(left: 6, right: 4),
                      child: recommendedSalonsList(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                          '${widget.currentAddress}',
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
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 12, color: Colors.black12)
                ]),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: findSalonController,
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
                        suffixIcon: InkWell(
                          onTap: () {
                            entityNameApiCall();
                          },
                          child: Icon(
                            Icons.search,
                            color: AppColor.blueColor,
                          ),
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
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

  getUserInfo() async {
    custId = await stylebuddyPreferences.getCustId();
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

  entityNameApiCall() async {
    final getEntityNameProvider =
        Provider.of<SearchSalonAutoProvider>(context, listen: false);

    var body = {"prefix": findSalonController.text};
    print('reqPayload :- $body');

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await getEntityNameProvider.getPostEntityNameData(
        Config.strBaseURL + Config.envVariable + getSearchSalonAutocompleteURL,
        body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      print("data : ${result.body}");

      salonNameList = result.body;
      Loader.hide();

      Loader.hide();
    } else {
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
