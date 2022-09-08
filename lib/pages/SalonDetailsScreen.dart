import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SalonDetailsScreen extends StatefulWidget {
  @override
  _SalonDetailsScreenState createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.blueColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              topBarWidget(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget topBarWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: height * 0.39,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/android/Customer_Assets/Salon_Details/salon_bg.png',
                  ))),
          padding: EdgeInsets.only(right: 14, top: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    child: SvgPicture.asset(
                      'assets/images/android/Customer_Assets/Booking_slot/close.svg',
                      height: 22,
                      width: 22,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: height * 0.21,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Text(
              'Green Trends',
              style: TextStyle(
                  color: AppColor.whiteColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
        ),
        Positioned(
            top: height * 0.21,
            child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (rating) {
                  print(rating);
                }))
      ],
    );
  }
}
