import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Future<Position> _location;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
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
    return await Geolocator.getCurrentPosition();
  }

  BitmapDescriptor pinLocationIcon;
  
  Completer<GoogleMapController> _controller = Completer();
  final geo = Geoflutterfire();
  @override
  void initState() {
    _location = _determinePosition();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/scooter.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection("DeliveryLocations")
          .document('bHd3UsNnd42O7Vd4OTr0')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          print(snapshot.connectionState);
        }

        if (snapshot.hasData) {
          final data = snapshot.data.data['location'] as GeoPoint;
          Set<Marker> _markers = {};
          _markers.add(Marker(
                    markerId: MarkerId('delivery${data.longitude}'),
                    position: LatLng(data.latitude, data.longitude),
                    icon: pinLocationIcon));
              
          print(data.latitude.toString() + "||" + data.longitude.toString());
          return GoogleMap(
            // onMapCreated: (GoogleMapController controller) {
            //   _controller.complete(controller);
            //   setState(() {
            //     _markers.add(Marker(
            //         markerId: MarkerId('delivery'),
            //         position: LatLng(data.latitude, data.longitude),
            //         icon: pinLocationIcon));
            //   });
            // },
            markers: _markers,
            initialCameraPosition: CameraPosition(
                zoom: 20, target: LatLng(data.latitude, data.longitude)),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
