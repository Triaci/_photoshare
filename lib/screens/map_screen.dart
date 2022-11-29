import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/place_action.dart';
import '../components/place_dialog.dart';
import '../models/memoria_model.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> markers = [];

  @override
  void initState() {
    Geolocator.getCurrentPosition().then((Position pos) {
      addMarker(
          pos.latitude, pos.longitude, "currentPosition", "Eu estou aqui!");
    }).catchError((error) => print(error.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // -24.7212103,-53.761694 Fag Toledo

    return Scaffold(
      appBar: AppBar(
        actions: placeActions(context),
        title: Text('Map'),
      ),
      body: Container(
        child: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(-24.7212103, -53.761694), zoom: 18),
          zoomControlsEnabled: false,
          markers: Set<Marker>.of(markers),
          onLongPress: (LatLng position) {
            Place place =
                new Place(0, "", position.latitude, position.longitude, "");
            PlaceDialog dialog = PlaceDialog(place, true);
            createMemory(Memoria(
                titulo: "esse lugar foi incrível",
                corpo:
                    "Latitude $position.latitude Longitude $position.longitude",
                data: DateTime.now()));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int here = markers.indexWhere(
              (position) => position.markerId == MarkerId('currentPosition'));
          Place place;
          if (here == -1) {
            place = new Place(0, "", 0, 0, "");
          } else {
            LatLng position = markers[here].position;
            place = new Place(0, "", position.latitude, position.longitude, "");
          }
          PlaceDialog dialog = PlaceDialog(place, true);
        },
        child: Icon(
          Icons.add_location,
        ),
      ),
    );
  }

  void addMarker(
      double latitude, double longitude, String markerId, String markerTitle) {
    print('adicionou ${markerId}');
    final marker = Marker(
        markerId: MarkerId(markerId),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: markerTitle),
        icon: (markerId == 'currentPosition')
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
            : BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange));
    markers.add(marker);
    setState(() {
      markers = markers;
    });
  }

  Future createMemory(Memoria memoria) async {
    final docUser = FirebaseFirestore.instance.collection('memorias').doc();

    final json = {
      'titulo': memoria.titulo,
      'corpo': memoria.corpo,
      'data': memoria.data
    };

    await docUser.set(json);
  }
}
