import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:mac_address/mac_address.dart';
import 'package:provider/provider.dart';
import 'package:style_buddy/pages/SplashScreen.dart';
import 'package:style_buddy/providers/BookAppointmentProvider.dart';
import 'package:style_buddy/providers/EmailAndMobileValidationProvider.dart';
import 'package:style_buddy/providers/GIveFeedbackProvider.dart';
import 'package:style_buddy/providers/GetAvailableServicesProvider.dart';
import 'package:style_buddy/providers/GetMasterListProvider.dart';
import 'package:style_buddy/providers/GetMyStyleMasterProvider.dart';
import 'package:style_buddy/providers/GetRecommendedSalonProvider.dart';
import 'package:style_buddy/providers/GetSBProfileDataProvider.dart';
import 'package:style_buddy/providers/LoginProvider.dart';
import 'package:style_buddy/providers/MonthWiseAppointmentProvider.dart';
import 'package:style_buddy/providers/RegistrationProvider.dart';
import 'package:style_buddy/providers/SearchSalonAutoProvider.dart';
import 'package:style_buddy/providers/UpdateProfileProvider.dart';
import 'package:style_buddy/utils/AppColor.dart';
import 'dart:io' show Platform;
import 'package:style_buddy/utils/ConstantsVariable.dart';
import 'package:style_buddy/utils/StylebuddyPreferences.dart';
import 'package:location/location.dart' as locations;

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider()),
      ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ChangeNotifierProvider<EmailAndMobileValidationProvider>(
          create: (_) => EmailAndMobileValidationProvider()),
      ChangeNotifierProvider<GetMyStyleMasterProvider>(
          create: (_) => GetMyStyleMasterProvider()),
      ChangeNotifierProvider<SearchSalonAutoProvider>(
          create: (_) => SearchSalonAutoProvider()),
      ChangeNotifierProvider<GetMasterListProvider>(
        create: (_) => GetMasterListProvider(),
      ),
      ChangeNotifierProvider<GiveFeedbackProvider>(
        create: (_) => GiveFeedbackProvider(),
      ),
      ChangeNotifierProvider<GetAvailableServicesProvider>(
        create: (_) => GetAvailableServicesProvider(),
      ),
      ChangeNotifierProvider<BookAppointmentProvider>(
        create: (_) => BookAppointmentProvider(),
      ),
      ChangeNotifierProvider<GetSBProfileDataProvider>(
        create: (_) => GetSBProfileDataProvider(),
      ),
      ChangeNotifierProvider<UpdateProfileProvider>(
        create: (_) => UpdateProfileProvider(),
      ),
      ChangeNotifierProvider<MonthWiseAppointmentProvider>(
        create: (_) => MonthWiseAppointmentProvider(),
      ),
      ChangeNotifierProvider<GetRecommendedSalonProvider>(
        create: (_) => GetRecommendedSalonProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String deviceMacAddress = '';
  String deviceId = '';
  StylebuddyPreferences styleBuddyPreferences = StylebuddyPreferences();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late bool serviceEnabled;
  late LocationPermission permission;
  locations.Location location = new locations.Location();

  @override
  void initState() {
    //   SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.initState();
    initPlatformState();
    // styleBuddyPreferences.clearAllSharedPreferences();
    getLocationPermistions();
    setState(() {});
  }

  void didChangeDependencies() {
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/android/Onboarding/onboarding1.svg'),
      context,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/android/Onboarding/onboarding2.svg'),
      context,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/android/Onboarding/onboarding3.svg'),
      context,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Style Buddy',
        theme: ThemeData(
          brightness: Brightness.light,
          //  primarySwatch: AppColor.appColor,
          primaryColor: AppColor.whiteColor,
          fontFamily: "Raleway",
        ),
        home: SplashScreen());
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          isAndroid = true;
          deviceId = build.androidId!;
        });
        styleBuddyPreferences.setDeviceId(deviceId);
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          isIos = true;
          deviceId = data.identifierForVendor!;
        });
        styleBuddyPreferences.setDeviceId(deviceId);
      }
      //get the mac address
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }

    if (!mounted) return;

    setState(() {
      if (platformVersion == "" || platformVersion == null) {
        deviceMacAddress = deviceId;
        styleBuddyPreferences.setDeviceMac(deviceMacAddress);
      } else {
        deviceMacAddress = platformVersion;
        styleBuddyPreferences.setDeviceMac(deviceMacAddress);
      }
    });
  }

  Future<String?> getCountryName() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final LocatitonGeocoder geocoder = LocatitonGeocoder(mapApiKey);
    final coordinates = new Coordinates(position.latitude, position.longitude);

    final addresses = await geocoder.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("CountryName : ${first.countryName}");
    print("City Name : ${first.subAdminArea}");
    await styleBuddyPreferences.setCountryName(first.countryName.toString());
    await styleBuddyPreferences.setCityName(first.subAdminArea.toString());
    await styleBuddyPreferences.setCurrentAdd(first.addressLine.toString());

    return first.countryName;
  }

  getLocationPermistions() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if (permission == LocationPermission.always) {
      getCountryName();
    }
    if (permission == LocationPermission.whileInUse) {
      getCountryName();
    }
  }
}
