import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/utils/constants.dart';

class Repository {
  Stream<LatLng> getLocation() {
    final user = FirebaseAuth.instance.currentUser;
    LatLng lonlat = const LatLng(0, 0);
    FirebaseFirestore.instance
        .collection(kState)
        .doc(user!.uid)
        .snapshots()
        .listen((event) {
      lonlat = LatLng(event['long'], event['lat']);
    });
    return Stream.value(lonlat);
  }

  bool updateLocation() {
    final user = FirebaseAuth.instance.currentUser;
    LatLng lonlat = const LatLng(0, 0);
    if (user == null) {
      return false;
    }
    String type =
        getStringAsync(kState) == kStudent ? kStudentBase : kOperatorBase;
    Geolocator.getCurrentPosition().then((value) {
      log("here ${value.latitude} ${value.longitude}");
      lonlat = LatLng(value.latitude, value.longitude);

      FirebaseFirestore.instance.collection(type).doc(user.uid).set({
        'long': value.longitude.toString(),
        'lat': value.latitude.toString()
      }, SetOptions(merge: true));
      return true;

      placemarkFromCoordinates(value.latitude, value.longitude)
          .then((placeMarker) {
        /*  curLocControl.text =
            ' ${placeMarker.first.subAdministrativeArea} ${placeMarker.first.locality!},  ${placeMarker.first.administrativeArea!} ';
        log(placeMarker); */
      });
    });
    return false;
  }
}

final repoProvider = Provider<Repository>((ref) {
  return Repository();
});

final getLatestLocationProvider = StreamProvider<LatLng>((ref) async* {
  yield* ref.watch(repoProvider).getLocation();
});

final uploadLocationProvider = FutureProvider((ref) async {
  return Timer.periodic(const Duration(seconds: 5), (event) {
    ref.watch(repoProvider).updateLocation();
    log('timer called');
  });
});
