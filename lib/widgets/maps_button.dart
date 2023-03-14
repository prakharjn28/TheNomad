import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:location/location.dart';

class MapButton extends StatefulWidget {
  final LatLng location;

  const MapButton({Key? key, required this.location}) : super(key: key);

  @override
  _MapButtonState createState() => _MapButtonState();
}

class _MapButtonState extends State<MapButton> {
  late GoogleMapController mapController;
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    checkLocationPermissions();
  }

  Future<void> checkLocationPermissions() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> openMap() async {
    LatLng loca = widget.location;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${loca.latitude},${loca.longitude}';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng loca = widget.location;
    return Stack(children: [
      GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.location,
          zoom: 17,
        ),
        mapType: MapType.normal,
        myLocationEnabled: _permissionGranted == PermissionStatus.granted,
        onMapCreated: (controller) {
          mapController = controller;
        },
        markers: {
          Marker(
            markerId: MarkerId('marker'),
            position: LatLng(loca.latitude, loca.longitude),
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
      ),
      Positioned(
        bottom: 16,
        right: 16,
        child: ElevatedButton(
          onPressed: () {
            // handle button press here
            openMap();
          },
          child: Text('Show Map'),
        ),
      ),
    ]);
  }
}
