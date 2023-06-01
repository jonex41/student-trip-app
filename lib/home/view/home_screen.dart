import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/utils/colors.dart';

import '../provider/home_page_provider.dart';

class HomePage extends HookConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  // static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  PickResult? selectedPlace;
  final bool _showPlacePickerInContainer = false;
  final bool _showGoogleMapInContainer = false;

  final bool _mapsInitialized = false;
  final String _mapsRenderer = "latest";

  final listAddress = [
    "Admin building",
    "Faculty of BCS",
    "Faculty building area",
    "Female hostel4",
    "EDSU male hostel 3 ",
    "Male hostel 1",
    "EDSU health center",
    "Female hostel1",
  ];

  void initRenderer() {
    if (_mapsInitialized) return;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      switch (_mapsRenderer) {
        case "legacy":
          (mapsImplementation as GoogleMapsFlutterAndroid)
              .initializeWithRenderer(AndroidMapRenderer.legacy);
          break;
        case "latest":
          (mapsImplementation as GoogleMapsFlutterAndroid)
              .initializeWithRenderer(AndroidMapRenderer.latest);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var initialPosition = LatLng(2, 1);
    var markers = {
      Marker(
        markerId: const MarkerId('Admin building'),
        position: const LatLng(7.1358369, 6.3078127),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: 'Admin building',
          snippet: 'Admin building',
          onTap: () {
            ref.read(addressProvider2.notifier).state = [
              'Admin building',
              '7.1358369',
              '6.3078127'
            ];
            context.pop();
          },
        ),
      ),
      Marker(
        markerId: const MarkerId('Female hostel1'),
        position: const LatLng(7.1390879, 6.3037136),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: 'Female hostel1',
          snippet: 'Female hostel1',
          onTap: () {
            ref.read(addressProvider2.notifier).state = [
              'Female hostel1',
              '7.1390879',
              '6.3037136'
            ];
            context.pop();
          },
        ),
      ),
      Marker(
        markerId: const MarkerId('EDSU health center'),
        position: const LatLng(7.1370587, 6.305032),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: 'EDSU health center',
          snippet: 'EDSU health center',
          onTap: () {
            ref.read(addressProvider2.notifier).state = [
              'EDSU health center',
              '7.1370587',
              '6.305032'
            ];
            context.pop();
          },
        ),
      ),
      Marker(
        markerId: const MarkerId('Male hostel 1'),
        position: const LatLng(7.1336044, 6.2970287),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: 'Male hostel 1',
          snippet: 'Male hostel 1',
          onTap: () {
            ref.read(addressProvider2.notifier).state = [
              'Male hostel 1',
              '7.1336044',
              ' 6.2970287'
            ];
            context.pop();
          },
        ),
      ),
      Marker(
        markerId: const MarkerId('EDSU male hostel 3 '),
        position: const LatLng(7.1449509, 6.294641),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: 'EDSU male hostel 3 ',
          snippet: 'EDSU male hostel 3 ',
          onTap: () {
            ref.read(addressProvider2.notifier).state = [
              'EDSU male hostel 3 ',
              '7.1449509',
              '6.294641'
            ];
            context.pop();
          },
        ),
      ),
      Marker(
        markerId: const MarkerId('Female hostel4'),
        position: const LatLng(7.1444604, 6.2943163),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: 'Female hostel4',
          snippet: 'Female hostel4',
          onTap: () {
            ref.read(addressProvider2.notifier).state = [
              'Female hostel4',
              '7.1444604',
              ' 6.2943163'
            ];
            context.pop();
          },
        ),
      ),
      Marker(
        markerId: const MarkerId('Faculty building area'),
        position: const LatLng(7.1519135, 6.3016819),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: 'Faculty building area',
          snippet: 'Faculty building area',
          onTap: () {
            ref.read(addressProvider2.notifier).state = [
              'Faculty building area',
              '7.1519135',
              ' 6.3016819'
            ];
            context.pop();
          },
        ),
      ),
      Marker(
        markerId: const MarkerId('Faculty of BCS'),
        position: const LatLng(7.1459536, 6.2966428),
        // icon: BitmapDescriptor.,

        infoWindow: InfoWindow(
          title: 'Faculty of BCS',
          snippet: 'Faculty of BCS',
          onTap: () {
            ref.read(addressProvider2.notifier).state = [
              'Faculty of BCS',
              '7.1459536',
              ' 6.2966428'
            ];
            context.pop();
          },
        ),
      )
    };

    final curLocControl = useTextEditingController();
    final initText = useState('');
    final mapType = useState<MapType>(MapType.normal);
    final changelayout = useState(true);
    final initialPosition = useState<LatLng>(const LatLng(7.142133, 6.301505));
    Geolocator.getCurrentPosition().then((value) {
      log("here ${value.latitude} ${value.longitude}");
      initialPosition.value = LatLng(value.latitude, value.longitude);
      placemarkFromCoordinates(value.latitude, value.longitude)
          .then((placeMarker) {
        curLocControl.text =
            ' ${placeMarker.first.subAdministrativeArea} ${placeMarker.first.locality!},  ${placeMarker.first.administrativeArea!} ';
        log(placeMarker);
      });
    });
    void handleClick(String value) {
      if (value == 'Hybrid') {
        mapType.value = MapType.hybrid;
      } else if (value == 'None') {
        mapType.value = MapType.none;
      } else if (value == 'Normal') {
        mapType.value = MapType.normal;
      } else if (value == 'Terrain') {
        mapType.value = MapType.terrain;
      } else if (value == 'Satellite') {
        mapType.value = MapType.satellite;
      }
    }

    /*  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              TextField(
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.blueAccent,
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.people),
                hintText: "Where to?",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                    borderRadius: BorderRadius.circular(25.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 32.0),
                    borderRadius: BorderRadius.circular(25.0)))),
      

                            ],
                        ),
                      );
                    }); */

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Pick Destination"),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Hybrid', 'none', 'Normal', 'Terrain', 'Satellite'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      /*  drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerHeader(
              child: ListTile(
                title: const Text('Kofi'),
                subtitle: const Text('Edit Profile'),
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 25,
                  child: Icon(
                    PhosphorIcons.user_circle,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  context.pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                  // Update the state of the app.
                  // ...
                },
              ),
              decoration: BoxDecoration(),
            ),
            Divider(
              height: 4,
              color: Colors.grey,
            ),
            ListTile(
              minLeadingWidth: -5,
              leading: Icon(
                PhosphorIcons.credit_card,
                color: Colors.black,
              ),
              title: Align(
                child: new Text("Payment"),
                alignment: Alignment(-1.1, 0),
              ),
              onTap: () {
                context.pop();
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Select Payment"),
                                Text("Add new")
                              ],
                            ),
                            ListTile(
                              minLeadingWidth: -5,
                              leading: Icon(
                                PhosphorIcons.briefcase,
                                color: Colors.black,
                              ),
                              title: const Align(
                                child: Text("Cash Payment"),
                                alignment: Alignment(-1.1, 0),
                              ),
                              subtitle: const Align(
                                child: Text("Default method"),
                                alignment: Alignment(-1.1, 0),
                              ),
                              onTap: () {
                                // Update the state of the app.
                                // ...
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            ListTile(
              minLeadingWidth: -5,
              leading: Icon(
                PhosphorIcons.briefcase,
                color: Colors.black,
              ),
              title: const Align(
                child: Text("Work Trips"),
                alignment: Alignment(-1.1, 0),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              minLeadingWidth: -5,
              leading: Icon(
                PhosphorIcons.clock,
                color: Colors.black,
              ),
              title: Align(
                child: new Text("My Trip"),
                alignment: Alignment(-1.1, 0),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              minLeadingWidth: 0,
              leading: const Icon(
                PhosphorIcons.chat_text,
                color: Colors.black,
              ),
              title: const Align(
                child: Text("Support"),
                alignment: Alignment(-1.1, 0),
              ),
              onTap: () {
                context.pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportScreen()),
                );
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              minLeadingWidth: -5,
              leading: Icon(
                PhosphorIcons.gear,
                color: Colors.black,
              ),
              title: Align(
                child: new Text("Settings"),
                alignment: Alignment(-1.1, 0),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              minLeadingWidth: -5,
              leading: Icon(
                PhosphorIcons.question,
                color: Colors.black,
              ),
              title: Align(
                child: new Text("About"),
                alignment: Alignment(-1.1, 0),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: black4,
                  padding: EdgeInsets.only(right: 30, left: 30),
                  child: TextButton(
                    child: Text(
                      'Driver Mode',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            20.height
          ],
        ),
      ),
       */
      body: Stack(
        children: [
          // Positioned(bottom: 0, left: 0, child: ListView()),
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition.value,
              zoom: 16.0,
            ),
            myLocationEnabled: true,
            mapType: mapType.value,
            markers: Set<Marker>.of(markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (latlong) {
              /*  ref.read(addressProvider.notifier).state =
                    result.formattedAddress!; */
              context.pop();
            },
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...listAddress.map((e) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () {
                            if (e.contains("Admin building")) {
                              ref.read(addressProvider2.notifier).state = [
                                'Admin building',
                                '7.1358369',
                                '6.3078127'
                              ];
                            } else if (e.contains("Faculty building area")) {
                              ref.read(addressProvider2.notifier).state = [
                                'Faculty building area',
                                '7.1519135',
                                ' 6.3016819'
                              ];
                            } else if (e.contains("Female hostel4")) {
                              ref.read(addressProvider2.notifier).state = [
                                'Female hostel4',
                                '7.1444604',
                                ' 6.2943163'
                              ];
                            } else if (e.contains("EDSU male hostel 3")) {
                              ref.read(addressProvider2.notifier).state = [
                                'EDSU male hostel 3 ',
                                '7.1449509',
                                '6.294641'
                              ];
                            } else if (e.contains("Male hostel 1")) {
                              ref.read(addressProvider2.notifier).state = [
                                'Male hostel 1',
                                '7.1336044',
                                ' 6.2970287'
                              ];
                            } else if (e.contains("EDSU health center")) {
                              ref.read(addressProvider2.notifier).state = [
                                'EDSU health center',
                                '7.1370587',
                                '6.305032'
                              ];
                            } else if (e.contains("Female hostel1")) {
                              ref.read(addressProvider2.notifier).state = [
                                'Female hostel1',
                                '7.1390879',
                                '6.3037136'
                              ];
                            } else if (e.contains("Faculty of BCS")) {
                              ref.read(addressProvider2.notifier).state = [
                                'Faculty of BCS',
                                '7.1459536',
                                ' 6.2966428'
                              ];
                            }

                            context.pop();
                          },
                          child: SizedBox(
                            width: 160,
                            child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 3.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          5.0) //                 <--- border radius here
                                      ),
                                ),
                                child: Text(e)),
                          ),
                        ),
                      ))
                ],
              )),
          /*  PlacePicker(
              resizeToAvoidBottomInset:
                  false, // only works in page mode, less flickery
              apiKey: APIKeys.androidApiKey,
              hintText: "Find a place ...",
              searchingText: "Please wait ...",
              selectText: "Select place",
              outsideOfPickAreaText: "Place not in area",
              initialPosition: initialPosition.value,
              initialSearchString: initText.value,
              useCurrentLocation: true,
              selectInitialPosition: true,
              usePinPointingSearch: true,
              usePlaceDetailSearch: false,
              zoomGesturesEnabled: true,
              initialMapType: MapType.hybrid,
              zoomControlsEnabled: true,
              
              onMapCreated: (GoogleMapController controller) {
                print("Map created");
              },
              onPlacePicked: (PickResult result) {
                ref.read(addressProvider.notifier).state =
                    result.formattedAddress!;
                context.pop();
                print("Place picked: ${result.formattedAddress}");
              },
              onMapTypeChanged: (MapType mapType) {
                print("Map type changed to ${mapType.toString()}");
              },
              automaticallyImplyAppBarLeading: false,
              pickArea: CircleArea(
                center: const LatLng(7.142133, 6.301505),
                radius: 2000,
                fillColor: Colors.lightGreen.withGreen(255).withAlpha(32),
                strokeColor: Colors.lightGreen.withGreen(255).withAlpha(192),
                strokeWidth: 2,
              ),
              region: 'ng'
              // #region additional stuff
              // forceSearchOnZoomChanged: true,
              // automaticallyImplyAppBarLeading: false,
              // autocompleteLanguage: "ko",
              // region: 'au',
              // pickArea: CircleArea(
              //   center: HomePage.kInitialPosition,
              //   radius: 300,
              //   fillColor: Colors.lightGreen
              //       .withGreen(255)
              //       .withAlpha(32),
              //   strokeColor: Colors.lightGreen
              //       .withGreen(255)
              //       .withAlpha(192),
              //   strokeWidth: 2,
              // ),
              // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
              //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
              //   return isSearchBarFocused
              //       ? Container()
              //       : FloatingCard(
              //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
              //           leftPosition: 0.0,
              //           rightPosition: 0.0,
              //           width: 500,
              //           borderRadius: BorderRadius.circular(12.0),
              //           child: state == SearchingState.Searching
              //               ? Center(child: CircularProgressIndicator())
              //               : ElevatedButton(
              //                   child: Text("Pick Here"),
              //                   onPressed: () {
              //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
              //                     //            this will override default 'Select here' Button.
              //                     print("do something with [selectedPlace] data");
              //                     Navigator.of(context).pop();
              //                   },
              //                 ),
              //         );
              // },
              // pinBuilder: (context, state) {
              //   if (state == PinState.Idle) {
              //     return Icon(Icons.favorite_border);
              //   } else {
              //     return Icon(Icons.favorite);
              //   }
              // },
              // introModalWidgetBuilder: (context,  close) {
              //   return Positioned(
              //     top: MediaQuery.of(context).size.height * 0.35,
              //     right: MediaQuery.of(context).size.width * 0.15,
              //     left: MediaQuery.of(context).size.width * 0.15,
              //     child: Container(
              //       width: MediaQuery.of(context).size.width * 0.7,
              //       child: Material(
              //         type: MaterialType.canvas,
              //         color: Theme.of(context).cardColor,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(12.0),
              //         ),
              //         elevation: 4.0,
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(12.0),
              //           child: Container(
              //             padding: EdgeInsets.all(8.0),
              //             child: Column(
              //               children: [
              //                 SizedBox.fromSize(size: new Size(0, 10)),
              //                 Text("Please select your preferred address.",
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                   )
              //                 ),
              //                 SizedBox.fromSize(size: new Size(0, 10)),
              //                 SizedBox.fromSize(
              //                   size: Size(MediaQuery.of(context).size.width * 0.6, 56), // button width and height
              //                   child: ClipRRect(
              //                     borderRadius: BorderRadius.circular(10.0),
              //                     child: Material(
              //                       child: InkWell(
              //                         overlayColor: MaterialStateColor.resolveWith(
              //                           (states) => Colors.blueAccent
              //                         ),
              //                         onTap: close,
              //                         child: Row(
              //                           mainAxisAlignment: MainAxisAlignment.center,
              //                           children: [
              //                             Icon(Icons.check_sharp, color: Colors.blueAccent),
              //                             SizedBox.fromSize(size: new Size(10, 0)),
              //                             Text("OK",
              //                               style: TextStyle(
              //                                 color: Colors.blueAccent
              //                               )
              //                             )
              //                           ],
              //                         )
              //                       ),
              //                     ),
              //                   ),
              //                 )
              //               ]
              //             )
              //           ),
              //         ),
              //       ),
              //     )
              //   );
              // },
              // #endregion
              ),
           */

          /*  changelayout.value
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        top: 60, bottom: 60, right: 15, left: 15),
                    child: GestureDetector(
                      onTap: (() {
                        changelayout.value = !changelayout.value;
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()),
                        ); */
                      }),
                      child: Container(
                        color: black4,
                        child: TextField(
                            onTap: (() {}),
                            enabled: false,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 15.0),
                                prefixIcon: const Icon(Icons.search),
                                hintText: "Where to?",
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent, width: 32.0),
                                    borderRadius: BorderRadius.circular(5.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 32.0),
                                    borderRadius:
                                        BorderRadius.circular(25.0)))),
                      ),
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 60),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        5.height,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Your route',
                            style: GoogleFonts.poppins(
                                color: black,
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          ),
                        ),
                        15.height,
                        Container(
                          color: black4,
                          child: TextField(
                              onTap: (() {}),
                              enabled: false,
                              controller: curLocControl,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: const Icon(PhosphorIcons.circle),
                                  hintText: "Where to?",
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent,
                                          width: 32.0),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 32.0),
                                      borderRadius:
                                          BorderRadius.circular(25.0)))),
                        ),
                        13.height,
                        GestureDetector(
                          onTap: () {
                            // snackBar(context, title: "i am here");
                            initText.value = 'John';
                          },
                          child: Container(
                            color: black4,
                            child: TextField(
                                onTap: (() {}),
                                enabled: false,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    prefixIcon:
                                        const Icon(PhosphorIcons.circle),
                                    hintText: "Pick destination",
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blueAccent,
                                            width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(25.0)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
         */
        ],
      ),
    );
  }
}
