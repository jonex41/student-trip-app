import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/admin/user_location/views/static_map.dart';
import 'package:student_project/model/register_model.dart';
import 'package:student_project/utils/colors.dart';

import '../../../utils/constants.dart';
import '../../provider/admin_provider.dart';
import 'my_map.dart';

class UserLocationPage extends ConsumerWidget {
  const UserLocationPage(
      {super.key, required this.id, required this.type, required this.model});
  final String id;
  final String type;
  final RegisterModel model;

  @override
  Widget build(BuildContext context, WidgetRef refw) {
    DocumentReference ref = FirebaseFirestore.instance.collection(type).doc(id);
    final state = refw.watch(vehicleDtailsProviderId(id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Location'),
      ),
      body: ListView(
        // horizontal).
        padding: const EdgeInsets.all(15),
        children: <Widget>[
          10.height,
          if (type == kOperatorBase)
            state.when(
                data: (data) => data != null && data.imageUrl != null
                    ? CircleAvatar(
                        radius: 100.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            data.imageUrl!,
                          ),
                        ),
                      )
                    : Container(),
                error: (_, __) => Container(),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          if (type == kStudentBase && model.urlImage != null)
            CircleAvatar(
              radius: 100.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  model.urlImage!,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Image error!');
                  },
                ),
              ),
            ),
          10.height,
          Row(
            children: [
              const Text(
                'Name :',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              10.width,
              Text(
                model.name!,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              )
            ],
          ),
          20.height,
          Row(
            children: [
              const Text(
                'Person ID :',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              10.width,
              Text(
                model.personId!,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              )
            ],
          ),
          20.height,
          if (type == kStudentBase)
            Row(
              children: [
                const Text(
                  'Department ID:',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                10.width,
                Text(
                  model.departmentId!,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          20.height,
          Row(
            children: [
              const Text(
                'Phone NO:',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              10.width,
              Text(
                model.phone!,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          20.height,
          Row(
            children: [
              const Text(
                'Vehicle ID:',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              10.width,
              Text(
                model.vehicleId ?? 'No Id',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          20.height,
          Row(
            children: [
              const Text(
                'Tracker ID:',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              10.width,
              Text(
                model.id!,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
          40.height,
          /*  await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            kProgTripBase)
                                                        .doc(data[index]
                                                            .driverId)
                                                        .set({
                                                      kSLat: data[index].latS,
                                                      kSLong: data[index].longS,
                                                      kDLat: data[index].latD,
                                                      kDLong: data[index].longD
                                                    }); */
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection(kProgTripBase)
                .doc(id)
                .get(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data != null && snapshot.data!.exists) {
                    return GestureDetector(
                      onTap: () {
                        print(snapshot.data![kSLat]);
                        print(snapshot.data![kSLong]);
                        print(snapshot.data![kDLat]);
                        print(snapshot.data![kDLong]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderTrackingPage(
                                    name: model.name ?? 'User',
                                    sourceLocation: LatLng(
                                        snapshot.data![kSLat],
                                        snapshot.data![kSLong]),
                                    destination: LatLng(snapshot.data![kDLat],
                                        snapshot.data![kDLong]),
                                  )),
                        );
                      },
                      child: Row(
                        children: [
                          10.width,
                          const Text(
                            'Go to user Location',
                            style:
                                TextStyle(fontSize: 16, color: kPrimaryColor),
                          ),
                          const Icon(
                            PhosphorIcons.map_pin,
                            color: kPrimaryColor,
                          )
                        ],
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      print(model.lat.toDouble());
                      print(model.long.toDouble());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StaticMap(model.name!,
                                model.lat.toDouble(), model.long.toDouble(), id)),
                      );
                    },
                    child: Row(
                      children: [
                        10.width,
                        const Text(
                          'Go to user Location',
                          style: TextStyle(fontSize: 16, color: kPrimaryColor),
                        ),
                        const Icon(
                          PhosphorIcons.map_pin,
                          color: kPrimaryColor,
                        )
                      ],
                    ),
                  );

                  /* Center( // here only return is missing
                  child: Text(snapshot.data['email'])
                ); */
                }
              } else if (snapshot.hasError) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StaticMap(model.name!,
                              model.lat.toDouble(), model.long.toDouble(), id)),
                    );
                  },
                  child: Row(
                    children: [
                      10.width,
                      const Text(
                        'Go to user Location',
                        style: TextStyle(fontSize: 16, color: kPrimaryColor),
                      ),
                      const Icon(
                        PhosphorIcons.map_pin,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
         
         
          /*   StreamBuilder<RegisterModel>(
              stream: ref.snapshots().map((event) =>
                  RegisterModel.fromJson(event.data() as Map<String, dynamic>)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  RegisterModel datak = snapshot.data!;
                  String addressInString = '';
                  placemarkFromCoordinates(
                          datak.lat!.toDouble(), datak.long!.toDouble())
                      .then((placeMarker) {
                        addressInString = '${placeMarker.first.subAdministrativeArea} ${placeMarker.first.locality!},  ${placeMarker.first.administrativeArea!} ';
                    /*  curLocControl.text =
            ' ${placeMarker.first.subAdministrativeArea} ${placeMarker.first.locality!},  ${placeMarker.first.administrativeArea!} ';
        log(placeMarker); */
                  });

                  return Column(
                    children: [
                      const Text(
                        'Location ID:',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                       Text(
                        addressInString,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Row(
                        children: [
                          10.width,
                          Text(
                            'Latitude :${datak.lat} and Lontitude :${datak.lat}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Text("Something went wrong");
                }
              }),
          */
          40.height,
          /*  ElevatedButton(onPressed: () {}, child: const Text('Print')) */
        ],
      ),
    );
  }
}
