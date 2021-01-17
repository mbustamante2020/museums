import 'dart:async';
import 'package:exercise3/model/museum.dart';
import 'package:exercise3/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static const String id = 'map_screen';

  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  static final ApiClient apiClient = ApiClient();
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }
/*
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.3098850, 2.0003650),
    zoom: 10,
  );*/

  Future<Museum> initialPosition() async {
    final museums = await apiClient.getAllMuseums(1, 2);
    for (final museum in museums) return museum;
    return Museum(lat: 41.309885, lon: 2.000365);
  }

  CameraPosition _kGooglePlex() {
    /*  Museum auxMuseum;
    initialPosition().then((museum) {
      print('-----------> ${museum.lat} ${museum.lon}');
      auxMuseum = museum;
    }).catchError((error) {
      auxMuseum = Museum(lat: 0.0, lon: 0.0);
    });
    print('-----------> ${auxMuseum.lat} ${auxMuseum.lon}');
    return CameraPosition(
      target: LatLng(auxMuseum.lat, auxMuseum.lon),
      zoom: 10,
    );*/
    return CameraPosition(
      target: LatLng(41.3098850, 2.0003650),
      zoom: 10,
    );
  }

  Future<CameraPosition> initialPosition1() async {
    final museums = await apiClient.getAllMuseums(1, 2);
    Museum auxMuseum;
    for (final museum in museums) auxMuseum = museum;
    return CameraPosition(
      target: LatLng(auxMuseum.lat, auxMuseum.lon),
      zoom: 10,
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final museums = await apiClient.getAllMuseums(1, 10);
    setState(() {
      _markers.clear();
      for (final museum in museums) {
        final marker = Marker(
          markerId: MarkerId(museum.id),
          position: LatLng(museum.lat, museum.lon),
          infoWindow: InfoWindow(
            title: museum.title,
            snippet: museum.address,
          ),
        );
        _markers[museum.id] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Museums'),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex(),
        onMapCreated: _onMapCreated,
        markers: _markers.values.toSet(),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
