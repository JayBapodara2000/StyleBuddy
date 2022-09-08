import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:style_buddy/models/GetMyStyleMasterModel.dart';
import 'package:style_buddy/pages/BookingSuccessScreen.dart';
import 'package:style_buddy/providers/GetAvailableServicesProvider.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'package:style_buddy/utils/ConstantsVariable.dart';
import 'package:style_buddy/widgets/ServiceIconsWidget.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/GetAvailableServicesModel.dart';
import '../providers/BookAppointmentProvider.dart';
import '../providers/GetMyStyleMasterProvider.dart';
import '../utils/Config.dart';
import '../utils/ConstantsURL.dart';
import '../utils/StylebuddyPreferences.dart';

class CustomerBookingSlotScreen extends StatefulWidget {
  final int value;

  const CustomerBookingSlotScreen({Key? key, required this.value})
      : super(key: key);
  @override
  _CustomerBookingSlotScreenState createState() =>
      _CustomerBookingSlotScreenState();
}

class _CustomerBookingSlotScreenState extends State<CustomerBookingSlotScreen>
    with TickerProviderStateMixin {
  late Map<DateTime, List> _events;
  late List _selectedEvents;
  late AnimationController _animationController;
  TimeOfDay initialTime = TimeOfDay.now();
  String? _selectedTime;
  String? _coSelectedTime;

  StylebuddyPreferences stylebuddyPreferences = StylebuddyPreferences();
  TextEditingController selectedSlotController = TextEditingController();
  TextEditingController coSelectedSlotController = TextEditingController();

  var date;
  //int styleMasterId = 0;
  int custId = 0;

  List<Body> crazyStyleMastersListData = [];
  List<Body> coStyleMastersListData = [];
  bool isLoading = true;

  int totalTimeMM = 0;
  int totalTimeMMCoSM = 0;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<Body1> availableServicesList = [];
  List<dynamic> servicedtl = [];
  // CalendarController _calendarController;
  String deviceId = '';
  String deviceMacAdd = '';
  String createdfrom = '';
  Future<void> _showTimePicker() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: true);
      if (formattedTime != null) {
        setState(() {
          _selectedTime = formattedTime;
          selectedSlotController.text = _selectedTime!;
        });
      }
    }
  }

  Future<void> _showCoTimePicker() async {
    final TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: true);
      if (formattedTime != null) {
        setState(() {
          _coSelectedTime = formattedTime;
          coSelectedSlotController.text = _coSelectedTime!;
        });
      }
    }
  }

  @override
  void initState() {
    print('${widget.value}');
    getUserInfo();
    getDeviceIp();
    getDeviceIDAndMac();
    // getMasterListApiCall();
    getPlatform();
    //getSM();

    if (date == null) {
      setState(() {
        date = focusedDay.toString().split(' ');
      });
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () {
      getAvailableServicesApiCall();
      setState(() {});
    });

    super.didChangeDependencies();
    // Your code here
  }

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
              servicesWidget(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget topBarWidget() {
    return Container(
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: Text(
              'Appointment',
              style: TextStyle(
                  color: AppColor.whiteColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          _buildTableCalendar(),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffC6C7E3), width: 1),
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 18),
      child: TableCalendar(
        daysOfWeekVisible: true,
        availableGestures: AvailableGestures.all,
        weekendDays: [],
        calendarFormat: CalendarFormat.week,
        headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: TextStyle(
                color: AppColor.blackColor,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 18),
            formatButtonVisible: false,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10))),
        calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: AppColor.blueColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            todayDecoration: BoxDecoration(
              color: AppColor.blueColor.withOpacity(0.45),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            weekendDecoration: BoxDecoration(
              color: AppColor.blueColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            rowDecoration: BoxDecoration(
                border: Border.all(width: 0, color: AppColor.whiteColor)),
            todayTextStyle: TextStyle(
                color: AppColor.headingTitleColor,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16),
            selectedTextStyle: TextStyle(
                color: AppColor.whiteColor,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16),
            defaultTextStyle: TextStyle(
                color: AppColor.textBoxBorderColor,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16),
            defaultDecoration: BoxDecoration(
              color: AppColor.whiteColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            tableBorder: TableBorder.all(
              color: AppColor.whiteColor,
              width: 0,
            )),
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: selectedDay,
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
          date = focusedDay.toString().split(' ');
          print(date[0]);
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },
      ),
    );
  }

  Widget servicesWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 22),
      decoration: BoxDecoration(
          color: AppColor.lightGreyColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(44),
            topRight: Radius.circular(44),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            child: Row(
              children: [
                Text(
                  'Services',
                  style: TextStyle(
                      color: AppColor.headingTitleColor,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
                Text(
                  '  (you can select multiple)',
                  style: TextStyle(
                      color: AppColor.textBoxBorderColor,
                      fontFamily: 'Raleway',
                      fontSize: 15),
                ),
              ],
            ),
          ),
          (availableServicesList.length == 0)
              ? Container(
                  height: 108,
                  child: Center(
                    child: Text(
                      'No service available.',
                      style: TextStyle(
                          color: AppColor.textBoxBorderColor,
                          fontFamily: 'Raleway',
                          fontSize: 18),
                    ),
                  ),
                )
              : Container(
                  height: 108,
                  margin: EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: availableServicesList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, i) {
                      ServiceAllIconsWidget.getServiceIcons(
                          availableServicesList[i].iconid);
                      return Container(
                        margin: EdgeInsets.only(left: 6, right: 6, top: 0),
                        //choosing a service
                        child: GestureDetector(
                          onTap: () {
                            //?
                            setState(() {
                              availableServicesList[i].isSelected =
                                  !availableServicesList[i].isSelected;
                              Servicedetail newObject = new Servicedetail(
                                serviceid:
                                    availableServicesList[i].servicedtlid,
                                totaltime: availableServicesList[i].approxmm,
                              );
                              print(
                                  'selected service : ${availableServicesList[i].servicename} - ${availableServicesList[i].isSelected}');
                              //adding object to servicedtl
                              if (availableServicesList[i].isSelected == true) {
                                totalTimeMM = totalTimeMM +
                                    availableServicesList[i].approxmm!;
                                setState(() {
                                  servicedtl.add(newObject);
                                });
                                print('servicedtl  if: $servicedtl');
                              } else if (availableServicesList[i].isSelected ==
                                  false) {
                                totalTimeMM = totalTimeMM -
                                    availableServicesList[i].approxmm!;
                                setState(() {
                                  servicedtl.removeAt(i);
                                });

                                print('servicedtl  remove : $servicedtl');
                              }
                            });
                          },
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  //if service is chosen then show blue border else normal border
                                  availableServicesList[i].isSelected
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xff01519B59),
                                                blurRadius: 6,
                                                // offset: const Offset(0, 10),
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: AppColor.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Color(0xff01519B))),
                                            padding: EdgeInsets.all(8),
                                            child: Image.asset(
                                              '${ServiceAllIconsWidget.iconsAsset}',
                                              height: 32,
                                              width: 32,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: AppColor.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColor
                                                      .textBoxBorderColor)),
                                          padding: EdgeInsets.all(8),
                                          child: Image.asset(
                                            '${ServiceAllIconsWidget.iconsAsset}',
                                            height: 32,
                                            width: 32,
                                          ),
                                        ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "${availableServicesList[i].servicename}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.headingTitleColor,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              Positioned(
                                  right: 0,
                                  child: Container(
                                    child: SvgPicture.asset(
                                      availableServicesList[i].isSelected
                                          ? 'assets/images/android/Login/checked.svg'
                                          : 'assets/images/android/Login/unchecked.svg',
                                      width: 22,
                                      height: 22,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Text(
              'Book Slot',
              style: TextStyle(
                  color: AppColor.headingTitleColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
          ),
          //Bokking Slote slider

          Container(
              padding: EdgeInsets.only(
                left: 10,
                top: 12,
              ),
              child: Image.asset(
                  'assets/images/android/Customer_Assets/Booking_slot/slot_slider.PNG')),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  Selected Slot',
                      style: TextStyle(
                          color: AppColor.headingTitleColor,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showTimePicker();
                        //setCurrentTime();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33),
                          color: AppColor.whiteColor,
                          border: Border.all(
                              color: Color(0xffC6C7E3),
                              style: BorderStyle.solid),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff26273D29),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 0, right: 8),
                        height: 50.0,
                        width: width * 0.39,
                        child: TextFormField(
                          controller: selectedSlotController,
                          enabled: false,
                          style: TextStyle(
                              color: AppColor.blueColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Select time',
                            hintStyle: TextStyle(
                                color: AppColor.textBoxBorderColor,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 14),
                            fillColor: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '   Approx. time',
                      style: TextStyle(
                          color: AppColor.headingTitleColor,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        color: AppColor.whiteColor,
                        border: Border.all(
                            color: Color(0xffC6C7E3), style: BorderStyle.solid),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff26273D29),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(left: 0, right: 8),
                      height: 50.0,
                      width: width * 0.39,
                      child: TextFormField(
                        readOnly: true,
                        //controller: selectedSlotController,
                        enabled: false,
                        style: TextStyle(
                            color: AppColor.blueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: (totalTimeMM != 0)
                              ? '${totalTimeMM}min'
                              : 'Select Service',
                          hintStyle: (totalTimeMM != 0)
                              ? TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xff01519B),
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  color: AppColor.textBoxBorderColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 20, right: 14),
                          fillColor: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //BOOK THIS SLOT button
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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
                bookAppointmentApiCall();
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingSuccessScreen()));*/
              },
              child: Container(
                child: Text(
                  "BOOK THIS SLOT".toUpperCase(),
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

          (coStyleMastersListData.length != 0)
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: coStyleMastersListData.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return coStyleMasterWidget(i);
                  })
              : Container(),
        ],
      ),
    );
  }

  Widget coStyleMasterWidget(i) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: AppColor.lightBlueColor,
            border: Border.all(color: AppColor.blueColor, width: 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(44),
              topRight: Radius.circular(44),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 40),
              child: Text(
                'Co-Style Master',
                style: TextStyle(
                    color: AppColor.headingTitleColor,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 0),
                  margin: EdgeInsets.only(left: 7, right: 7, top: 10),
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
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  Selected Slot',
                        style: TextStyle(
                            color: AppColor.headingTitleColor,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showCoTimePicker();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33),
                            color: AppColor.whiteColor,
                            border: Border.all(
                                color: Color(0xffC6C7E3),
                                style: BorderStyle.solid),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff26273D29),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(left: 0, right: 8),
                          height: 50.0,
                          width: width * 0.39,
                          child: TextFormField(
                            controller: coSelectedSlotController,
                            enabled: false,
                            style: TextStyle(
                                color: AppColor.blueColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Select time',
                              hintStyle: TextStyle(
                                  color: AppColor.textBoxBorderColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 14),
                              fillColor: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '   Approx. time',
                        style: TextStyle(
                            color: AppColor.headingTitleColor,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33),
                          color: AppColor.whiteColor,
                          border: Border.all(
                              color: Color(0xffC6C7E3),
                              style: BorderStyle.solid),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff26273D29),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 0, right: 8),
                        height: 50.0,
                        width: width * 0.39,
                        child: TextFormField(
                          readOnly: true,
                          //controller: selectedSlotController,
                          enabled: false,
                          style: TextStyle(
                              color: AppColor.blueColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: (totalTimeMM != 0)
                                ? '${totalTimeMM}min'
                                : 'Select Service',
                            hintStyle: (totalTimeMM != 0)
                                ? TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff01519B),
                                    fontWeight: FontWeight.bold)
                                : TextStyle(
                                    color: AppColor.textBoxBorderColor,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 14),
                            fillColor: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //BOOK THIS SLOT button
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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
                  coSMBookAppointmentApiCall();
                },
                child: Container(
                  child: Text(
                    "BOOK THIS SLOT".toUpperCase(),
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
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  getUserInfo() async {
    custId = await stylebuddyPreferences.getCustId();
    getMyStyleMasterApiCall();
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

  //API call function for getting services
  Future<void> getAvailableServicesApiCall() async {
    final getAvailableServicesProvider =
        Provider.of<GetAvailableServicesProvider>(context, listen: false);

    var body = {
      "stylemasterid": widget.value,
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result =
        await getAvailableServicesProvider.getPostAvailableServicesData(
            Config.strBaseURL + Config.envVariable + getAvailableServicesURL,
            body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      for (var i = 0; i < result.body.length; i++) {
        setState(() {
          //styleMastersListData =result.body[i];
          availableServicesList.add(result.body[i]);
        });
      }
      print('data : $availableServicesList');
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

  //API call function declare
  coSMBookAppointmentApiCall() async {
    final bookAppointmentProvider =
        Provider.of<BookAppointmentProvider>(context, listen: false);
    //print('servicedetail :- ${servicedtl}');
    var body = {
      "stylemasterid": widget.value,
      "custid": custId,
      "servicedtl": servicedtl,
      "status": 1,
      "totaltimemm": totalTimeMM,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp,
      "servicedate": date[0] + ' ' + coSelectedSlotController.text
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await bookAppointmentProvider.getPostBookAppointmentdata(
        Config.strBaseURL + Config.envVariable + bookAppointmentURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Appointment is booked");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingSuccessScreen(),
          ));
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }

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
            print(coStyleMastersListData);
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
  bookAppointmentApiCall() async {
    final bookAppointmentProvider =
        Provider.of<BookAppointmentProvider>(context, listen: false);
    //print('servicedetail :- ${servicedtl}');
    var body = {
      "stylemasterid": widget.value,
      "custid": custId,
      "servicedtl": servicedtl,
      "status": 1,
      "totaltimemm": totalTimeMM,
      "deviceid": deviceId,
      "devicemac": deviceMacAdd,
      "createdfrom": createdfrom,
      "clientip": deviceIp,
      "servicedate": date[0] + ' ' + selectedSlotController.text
    };
    print('reqPayload :- $body');
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    var result = await bookAppointmentProvider.getPostBookAppointmentdata(
        Config.strBaseURL + Config.envVariable + bookAppointmentURL, body);
    print("apiResponse :- $result");

    if (result.statusCode == 200) {
      Loader.hide();
      Fluttertoast.showToast(msg: "Appointment is booked");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingSuccessScreen(),
          ));
      Loader.hide();
    } else {
      Loader.hide();
      Fluttertoast.showToast(msg: "$result");
    }
  }
}

class Servicedetail {
  int? serviceid;
  int? totaltime;

  Servicedetail({this.serviceid, this.totaltime});

  Servicedetail.fromJson(Map<String, dynamic> json) {
    serviceid = json['serviceid'];
    totaltime = json['totaltime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceid'] = this.serviceid;
    data['totaltime'] = this.totaltime;
    return data;
  }
}
