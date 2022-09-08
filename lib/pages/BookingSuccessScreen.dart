import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style_buddy/pages/SalonDetailsScreen.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';

class BookingSuccessScreen extends StatefulWidget {
  const BookingSuccessScreen({Key? key}) : super(key: key);

  @override
  _BookingSuccessScreenState createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.blueColor,
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            topBarWidget(),
            bookingSuccessfulWidget(),
          ],
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
          'assets/images/android/Customer_Assets/Sucess_slot/scessor_comb.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget bookingSuccessfulWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Expanded(
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
              height: height * 0.042,
            ),
            Text(
              'Booking',
              style: TextStyle(
                  color: AppColor.blueColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Text(
              'Successful',
              style: TextStyle(
                  color: AppColor.lightPinkColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Requested Service(s)',
                        style: TextStyle(
                            color: AppColor.textBoxBorderColor,
                            fontFamily: 'Raleway',
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/android/Customer_Assets/Sucess_slot/requested_service.svg',
                            // height: 26,
                            // width: 26,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '  Hair cut & Coloring',
                            style: TextStyle(
                                color: AppColor.blueColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                                fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Approx Duration',
                        style: TextStyle(
                            color: AppColor.textBoxBorderColor,
                            fontFamily: 'Raleway',
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/android/Customer_Assets/Sucess_slot/time.svg',
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '  1 hr',
                            style: TextStyle(
                                color: AppColor.blueColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                                fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //OK button
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SalonDetailsScreen()));
                },
                child: Container(
                  child: Text(
                    "OK".toUpperCase(),
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
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/android/Customer_Assets/Sucess_slot/get_direction.svg',
                    fit: BoxFit.cover,
                    width: 17,
                    height: 17,
                  ),
                  Text(
                    '  GET DIRECTION'.toUpperCase(),
                    style: TextStyle(
                        color: AppColor.headingTitleColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        fontFamily: 'Raleway',
                        fontSize: 17),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
