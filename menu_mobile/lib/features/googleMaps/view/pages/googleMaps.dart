import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:where/Common/Config/Palette.dart';

class GoogleMaps extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoogleMapsState();
  }
}

class GoogleMapsState extends State<GoogleMaps> {
  late GoogleMapController _googleMapController;
  final List<Marker>? _markers = [];
  static String position = '';
  void _getcurrentLocation() async {
    var currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _markers!.clear();
      final marker = Marker(
        markerId: MarkerId(_markers!.length.toString()),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      _googleMapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 18,
        ),
      ));
      _markers!.add(marker);
    });
  }

  void _getLocation(LatLng location) async {
    print(location);
    setState(() {
      _markers!.clear();
      final marker = Marker(
        markerId: MarkerId(_markers!.length.toString()),
        position: LatLng(location.latitude, location.longitude),
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(150),
      );
      _markers!.add(marker);
    });
  }

  @override
  void initState() {
    position = '';
    _markers!.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('map'),
        backgroundColor: Palette.primaryColor1,
        actions: [
          _markers!.length > 0
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      position = _markers![0].position.latitude.toString() +
                          "," +
                          _markers![0].position.longitude.toString();
                      print("position : " + position);
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'save location',
                    style: TextStyle(color: Palette.white),
                  ),
                )
              : Container()
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.048673631708905, 31.231604889035225),
          zoom: 13,
        ),
        onLongPress: _getLocation,
        markers: Set<Marker>.of(_markers!),
        onMapCreated: (controller) => _googleMapController = controller,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.primaryColor1,
        onPressed: _getcurrentLocation,
        child: Icon(Icons.my_location),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
