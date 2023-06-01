import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/constants.dart';

class StaticMap extends StatefulWidget {
  const StaticMap(this.name, this.lat, this.long,  this.id, {super.key});
  final double lat;
  final double long;
  final String name;
  final String id;

  @override
  State<StaticMap> createState() => _StaticMapState();
}

class _StaticMapState extends State<StaticMap> {
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    
    DocumentReference reference =
        FirebaseFirestore.instance
        .collection(kVehicles)
        .doc(widget.id);
    reference.snapshots().listen((snapshot) {
      snapshot.get(kSLat);
      snapshot.get(kSLong);
      snapshot.get(kDLat);
      snapshot.get(kDLong);
      
                       
    });
    //getLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var marker = {
      Marker(
        markerId: MarkerId('${widget.name} location'),
        position: LatLng(widget.lat, widget.long),
        // icon: BitmapDescriptor.,

        infoWindow: InfoWindow(
          title: 'User location',
          snippet: 'The selected users location',
          onTap: () {},
        ),
      )
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name} Location'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        markers: Set<Marker>.of(marker),
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 16.0,
        ),
      ),
    );
  }
}
