import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  CameraPosition? _kHTCNTT;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  static const double destinationLat = 20.98089;
  static const double destinationLng = 105.7872824;
//20.98089,105.7872824,21
  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((Position position) {
      setState(() {
        _kHTCNTT = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15.0,
        );
        _markers.add(
          Marker(
            markerId: MarkerId("My Location"),
            position: LatLng(destinationLat, destinationLng),
            infoWindow: InfoWindow(
              title: "Bãi đổ xe",
              snippet: "Minh hoạ đổ xe nè",
            ),
          ),
        );

        _getDirections(
            position.latitude, position.longitude, destinationLat, destinationLng);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kHTCNTT ?? CameraPosition(target: LatLng(destinationLat, destinationLng), zoom: 17.0,),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permission denied.';
        }
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print("Error getting location: $e");
      rethrow;
    }
  }

  Future<void> _getDirections(
      double startLat, double startLng, double endLat, double endLng) async {
    final apiKey = 'AIzaSyDkYtgCbxKgOPETKyig56LIG6a66xW-FTs'; // Replace with your API key


    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      if (decodedResponse['routes'].isEmpty) {
        throw 'No routes found';
      }

      List<LatLng> points = [];
      List<dynamic> steps = decodedResponse['routes'][0]['legs'][0]['steps'];

      if (steps.isNotEmpty) {
        steps.forEach((step) {
          // Sử dụng thư viện google_maps_flutter để giải mã đoạn mã Polyline
          final encodedPolyline = step['polyline']['points'];
          final List<LatLng> decodedPolyline =
          PolylinePoints().decodePolyline(encodedPolyline)
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

          points.addAll(decodedPolyline);
        });

        setState(() {
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            points: points,
            color: Colors.blue,
            width: 5,
          ));
        });
      } else {
        throw 'No steps found';
      }
    } else {
      throw 'Failed to load directions';
    }
  }
}
