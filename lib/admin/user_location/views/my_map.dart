import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_project/utils/api_key.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage(
      {super.key,
      required this.name,
      required this.sourceLocation,
      required this.destination});
  final LatLng sourceLocation;
  final LatLng destination;
  final String name;

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List<LatLng> polylineCoordinates = [];
  LatLng? currentLocation;
  var isStopped = false;
  @override
  void initState() {
    getPolyPoints();
    getCurrentLocation();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isStopped = true;
    super.dispose();
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      APIKeys.androidApiKey, // Your Google Map Key
      PointLatLng(
          widget.sourceLocation.latitude, widget.sourceLocation.longitude),
      PointLatLng(widget.destination.latitude, widget.destination.longitude),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }

  void getCurrentLocation() async {
    LatLng initialPosition = const LatLng(7.142133, 6.301505);
    currentLocation = initialPosition;

    Geolocator.getCurrentPosition().then((value) {
      currentLocation = LatLng(value.latitude, value.longitude);

      setState(() {});
    });
    GoogleMapController googleMapController = await _controller.future;

    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (isStopped) {
        timer.cancel();
      }
      Geolocator.getCurrentPosition().then((value) {
        currentLocation = LatLng(value.latitude, value.longitude);
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 16,
              target: LatLng(
                value.latitude,
                value.longitude,
              ),
            ),
          ),
        );

        if (mounted) setState(() {});
      });
      print("Dekhi 5 sec por por kisu hy ni :/");
    });

    /*  Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    print('1');
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    print('2');
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print('3');
        return;
      }
    }
    print('4');
    location.getLocation().then(
      (location) {
        print('5');
        currentLocation = location;
        setState(() {});
      },
    ); */
    print('6');
    /* // GoogleMapController googleMapController = await _controller.future;
    /* final GoogleMapController controller = await _controller.future;
    print('7');
    location.onLocationChanged.listen(
      (newLoc) {
        print('8');
        currentLocation = newLoc;
        print('9');
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        print('10');
        setState(() {});
      },
    );
  */ */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.name} Location",
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude, currentLocation!.longitude),
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(
                      currentLocation!.latitude, currentLocation!.longitude),
                ),
                Marker(
                  markerId: const MarkerId("source"),
                  position: LatLng(widget.sourceLocation.latitude,
                      widget.sourceLocation.longitude),
                ),
                Marker(
                  markerId: const MarkerId("destination"),
                  position: LatLng(widget.destination.latitude,
                      widget.destination.longitude),
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: const Color(0xFF7B61FF),
                  width: 6,
                ),
              },
            ),
      /* GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: sourceLocation,
          zoom: 13.5,
        ),
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: const Color(0xFF7B61FF),
            width: 6,
          ),
        },
        markers: {
          const Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          const Marker(
            markerId: MarkerId("destination"),
            position: destination,
          ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    */
    );
  }
}
/* 
class OrderTrackingPage extends StatefulWidget {
  OrderTrackingPage(
      {super.key,
      required this.originLatitude,
      required this.originLongitude,
      required this.destLatitude,
      required this.destLongitude});
  final double originLatitude;
  final double originLongitude;
  final double destLatitude;
  final double destLongitude;

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  late LatLng sourceLocation;
  late LatLng destination ;
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      APIKeys.androidApiKey, // Your Google Map Key
      PointLatLng(
          sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
   sourceLocation= LatLng(widget.originLatitude, widget.originLongitude);
   destination = LatLng(widget.destLatitude, widget.destLongitude);
    getPolyPoints();
    //getCurrentLocation();
    //setCustomMarkerIcon();
    super.initState();
  }

  void setCustomMarkerIcon() {
    /*  BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, "assets/Pin_source.png")
      .then(
    (icon) {
      sourceIcon = icon;
    },
  );
  BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, "assets/Pin_destination.png")
      .then(
    (icon) {
      destinationIcon = icon;
    },
  );
  BitmapDescriptor.fromAssetImage(
          ImageConfiguration.empty, "assets/Badge.png")
      .then(
    (icon) {
      currentLocationIcon = icon;
    },
  ); */
  }
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  icon: currentLocationIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: const MarkerId("source"),
                  icon: sourceIcon,
                  position: sourceLocation,
                ),
                Marker(
                  markerId: MarkerId("destination"),
                  icon: destinationIcon,
                  position: destination,
                ),
              },
              /*  markers: {
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!),
        ),
        const Marker(
          markerId: MarkerId("source"),
          position: sourceLocation,
        ),
        const Marker(
          markerId: MarkerId("destination"),
          position: destination,
        ),
      },*/
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: const Color(0xFF7B61FF),
                  width: 6,
                ),
              },
            ),
      /* GoogleMap(
  initialCameraPosition: const CameraPosition(
    target: sourceLocation,
    zoom: 13.5,
  ),
  markers: {
    const Marker(
      markerId: MarkerId("source"),
      position: sourceLocation,
    ),
    const Marker(
      markerId: MarkerId("destination"),
      position: destination,
    ),
  },
  polylines: {
    Polyline(
      polylineId: const PolylineId("route"),
      points: polylineCoordinates,
      color: const Color(0xFF7B61FF),
      width: 6,
    ),
  },
  onMapCreated: (mapController) {
    _controller.complete(mapController);
  },
),
    */
    );
  }
}
 */



















/* import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:student_project/utils/api_key.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      required this.originLatitude,
      required this.originLongitude,
      required this.destLatitude,
      required this.destLongitude});
  final double originLatitude;
  final double originLongitude;
  final double destLatitude;
  final double destLongitude;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = APIKeys.androidApiKey;

  @override
  void initState() {
    super.initState();
LatLng userPosition;

    location.onLocationChanged().listen((LocationData position) {
      setState(() {
          userPosition = LatLng(position.latitude, position.longitude);
        });
    });
    /// origin marker
    _addMarker(LatLng(widget.originLatitude, widget.originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(widget.destLatitude, widget.destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.originLatitude, widget.originLongitude), zoom: 15),
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polylines.values),
      )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
   
  controller.animateCamera(
   CameraUpdate.newCameraPosition(
    CameraPosition(target: userPosition, zoom: 16),
  ),
);
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(widget.originLatitude, widget.originLongitude),
        PointLatLng(widget.destLatitude, widget.destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }
}
 */