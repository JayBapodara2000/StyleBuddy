import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:style_buddy/pages/CustomerLandingScreen.dart';
import 'package:style_buddy/providers/GIveFeedbackProvider.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'package:style_buddy/utils/Config.dart';
import 'package:style_buddy/utils/ConstantsURL.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';
import 'package:style_buddy/utils/StylebuddyPreferences.dart';
import 'package:style_buddy/widgets/CustomeStarRatingWidget.dart';

class ServiceRatingScreen extends StatefulWidget {
  const ServiceRatingScreen({Key? key}) : super(key: key);

  @override
  _ServiceRatingScreenState createState() => _ServiceRatingScreenState();
}

class _ServiceRatingScreenState extends State<ServiceRatingScreen> {
  TextEditingController feedBackController = TextEditingController();

  StylebuddyPreferences stylebuddyPreferences = StylebuddyPreferences();

  String deviceId = '';
  String deviceMacAdd = '';
  String createdfrom = '';
  String feedback = '';

  int rating = 0;
  int custId = 0;

  @override
  void initState() {
    getDeviceIp();
    getDeviceIDAndMac();
    getPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.blueColor,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            children: [
              topBarWidget(),
              ratingWidget(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget topBarWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.35,
      child: Center(
        child: Image.asset(
          'assets/images/android/Customer_Assets/Rating/rating_pple.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget ratingWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: width,
          margin: EdgeInsets.only(top: height * 0.022),
          decoration: BoxDecoration(
              color: AppColor.lightGreyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(44),
                topRight: Radius.circular(44),
              )),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.072,
              ),
              Text(
                'Your opinion matter to us!',
                style: TextStyle(
                    color: AppColor.headingTitleColor,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'We work super hard to give good service\nto you, and would love to know.\n\nHow would you rate our app ?',
                  style: TextStyle(
                      color: AppColor.headingTitleColor,
                      fontFamily: 'Raleway',
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height * 0.034,
              ),
              //rating star
              Container(
                child: StarRating(
                  onRatingChanged: (rating) {
                    setState(() {
                      this.rating = rating;
                      print('rating : $rating');
                    });
                    if (rating == 1) {
                      setState(() {
                        feedback = 'Very Bad';
                        print('feedback : $feedback');
                      });
                    }
                    if (rating == 2) {
                      setState(() {
                        feedback = 'Poor';
                        print('feedback : $feedback');
                      });
                    }
                    if (rating == 3) {
                      setState(() {
                        feedback = 'Good';
                        print('feedback : $feedback');
                      });
                    }
                    if (rating == 4) {
                      setState(() {
                        feedback = 'Very Good';
                        print('feedback : $feedback');
                      });
                    }
                    if (rating == 5) {
                      setState(() {
                        feedback = 'Excelent';
                        print('feedback : $feedback');
                      });
                    }
                  },
                  rating: rating,
                  starCount: 5,
                ),
              ),
              /*          Container(
                height: 30,
                width: width,
                alignment: Alignment.center,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, snapshot) {
                      return Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/images/android/Customer_Assets/Rating/Icon material-stars.svg',
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ), */
              SizedBox(
                height: height * 0.026,
              ),
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
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: false,
                    maxLines: 5,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: AppColor.blueColor,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffC6C7E3),
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC6C7E3)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffC6C7E3),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Feedback',
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
                    controller: feedBackController,
                    validator: (controller) {
                      if (controller == null || controller.isEmpty) {
                        return 'Feedback Field is Required';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              //SUBMIT button
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                    horizontal: 30, vertical: height * 0.032),
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
                    giveFeedbackApiCall();
                  },
                  child: Container(
                    child: Text(
                      "SUBMIT".toUpperCase(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NO,THANKS'.toUpperCase(),
                    style: TextStyle(
                        color: AppColor.headingTitleColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        fontFamily: 'Raleway',
                        fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.026,
              ),
            ],
          ),
        ),
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

  getUserInfo() async {
    custId = await stylebuddyPreferences.getCustId();
  }

  giveFeedbackApiCall() async {
    final giveFeedbackProvider =
        Provider.of<GiveFeedbackProvider>(context, listen: false);

    var body = {
      "actservdtlid": 2,
      "custid": custId,
      "rate": rating,
      "fb": feedback,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp,
    };
    print('ReqPayload : $body');

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await giveFeedbackProvider.getPostGiveFeedbackData(
        Config.strBaseURL + Config.envVariable + giveFeedbackURL, body);
    print('ApiResponse : $result');

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Submitted");
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => CustomerLandingScreen(),
      //     ));

    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}
