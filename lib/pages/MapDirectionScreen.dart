import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:style_buddy/utils/AppColor.dart';

class MapDirectionScreen extends StatefulWidget {
  @override
  State<MapDirectionScreen> createState() => _MapDirectionScreenState();
}

class _MapDirectionScreenState extends State<MapDirectionScreen> {
  static late double latitudes;
  static late double longitudes;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGooglePlex;
  final Set<Marker> _markers = {};
  bool isLoading = true;

  var getLatLong;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getPosition();
    });
    super.initState();
  }

  isLoader() {
    Loader.show(context, progressIndicator: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? isLoader()
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  markers: _markers,
                  onTap: _handleTap,
                  initialCameraPosition: _kGooglePlex!,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
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
                        Navigator.of(context).pop(getLatLong);
                      },
                      child: Container(
                        child: Text(
                          "Next".toUpperCase(),
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
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 48),
        child: FloatingActionButton(
          backgroundColor: AppColor.whiteColor,
          onPressed: _goToTheCurrentLocation,
          child: Icon(
            Icons.gps_fixed,
            color: AppColor.blueColor,
          ),
        ),
      ),
    );
  }

  _handleTap(LatLng point) {
    _markers.clear();
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));

      getLatLong = {"latitude": point.latitude, "longitude": point.longitude};

      print('getLatLong : $getLatLong');
    });
  }

  getPosition() async {
    /*   setState(() {
      isLoading = true;
    }); */
    // Loader.show(context, progressIndicator: CircularProgressIndicator());
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudes = position.latitude;
      longitudes = position.longitude;
    });
    _kGooglePlex =
        CameraPosition(target: LatLng(latitudes, longitudes), zoom: 29.20);
    setState(() {
      isLoading = false;
    });
    Loader.hide();

    print('data : {latitudes, $longitudes');
  }

  Future<void> _goToTheCurrentLocation() async {
    getPosition();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex!));
  }
}
