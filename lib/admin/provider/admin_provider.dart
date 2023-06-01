import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:student_project/auth/helpers.dart';
import 'package:student_project/data/models/booking_model.dart';
import 'package:student_project/model/register_model.dart';
import 'package:student_project/model/vehicle_model.dart';
import 'package:student_project/utils/constants.dart';

import '../../model/vehicle_operation_model.dart';

final countProvider = StateProvider<int>((ref) {
  return 0;
});

final userListProvider = FutureProvider.autoDispose<List<RegisterModel>>((ref) async {
  return ref.watch(repoProvider).getUser();
});
final operatorListProvider = FutureProvider.autoDispose<List<RegisterModel>>((ref) async {
  return ref.watch(repoProvider).getOperator();
});
final bookingListProvider = FutureProvider.autoDispose<List<BookingModel>>((ref) async {
  return ref.watch(repoProvider).getAllUserBookings();
});

final singleUserProvider = FutureProvider.autoDispose<RegisterModel?>((ref) async {
  return ref.watch(repoProvider).getSingleUser();
});

final generalbookingListProvider =
    FutureProvider<List<BookingModel>>((ref) async {
  return ref.watch(repoProvider).getBookingsDetail();
});

final vehicleListProvider =
    FutureProvider.autoDispose<List<VehicleOperationModel>>((ref) async {
  return ref.watch(repoProvider).getVehicleOperation();
});

final operatorBookingListProvider =
    FutureProvider.autoDispose<List<BookingModel>>((ref) async {
  return ref.watch(repoProvider).getAllOperatorBookings();
});

final vehicleDtailsProvider = FutureProvider.autoDispose<VehicleModel?>((ref) async {
  return ref.watch(repoProvider).getVehiclesDetail();
});

final vehicleDtailsProviderId = FutureProvider.autoDispose.family<VehicleModel?, String>((ref, id) async {
  return ref.watch(repoProvider).getVehiclesDetailId(id);
});
final repoProvider = Provider<Repository>((ref) {
  return Repository();
});

class Repository {
  Future<RegisterModel?> getSingleUser() async {
    RegisterModel? model;
    final user = FirebaseAuth.instance.currentUser;
    log('id user ${user!.uid}');
    String value = getStringAsync(kState);
    if (kStudent.toLowerCase().contains(value)) {
      value = kStudentBase;
    } else {
      value = kOperatorBase;
    }

    log('wdwdwdwdw    $value');
     FirebaseFirestore.instance
        .collection(value)
        .doc(user.uid)
        .get()
        .then((doc) {
      final data = doc.data()!;
      log('id doc $data');

      return  RegisterModel.fromJson(data);
    });
    return model;
  }

  Future<List<RegisterModel>> getUser() async {
    var list = <RegisterModel>[];
    await FirebaseFirestore.instance
        .collection(kStudentBase)
        .get()
        .then((value) {
      for (DocumentSnapshot doc in value.docs) {
        final data = doc.data()! as Map<String, dynamic>;
        RegisterModel model = RegisterModel.fromJson(data);
        model.id = doc.id;
        list.add(model);
      }
    });
    return Future.value(list);
  }

  Future<VehicleModel?> getVehiclesDetail() async {
    final user = FirebaseAuth.instance.currentUser;
    VehicleModel? model;
    await FirebaseFirestore.instance
        .collection(kVehicles)
        .doc(user!.uid)
        .get()
        .then((doc) {
      final data = doc.data()!;
      model = VehicleModel.fromJson(data);
      log('cccc $data');

      return model;
    });
    return model;
  }

  Future<VehicleModel?> getVehiclesDetailId(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    VehicleModel? model;
    await FirebaseFirestore.instance
        .collection(kVehicles)
        .doc(id)
        .get()
        .then((doc) {
      final data = doc.data()!;
      model = VehicleModel.fromJson(data);
      log('cccc $data');

      return model;
    });
    return model;
  }

  Future<List<BookingModel>> getBookingsDetail() async {
    var list = <BookingModel>[];
    await FirebaseFirestore.instance.collection(kBookingList).get().then((doc) {
      for (DocumentSnapshot doc in doc.docs) {
        final data = doc.data()! as Map<String, dynamic>;
        BookingModel model = BookingModel.fromJson(data);
        model.bookinRef = doc.id;
        list.add(model);
        //log('wwwwwwwwwwwwwwwwwwwwwwwwwwwww         ${model.name}');
      }
    });
    return list;
  }

  Future<List<VehicleOperationModel>> getVehicleOperation() async {
    var list = <VehicleOperationModel>[];
    await FirebaseFirestore.instance.collection(kTripDetails).get().then((doc) {
      for (DocumentSnapshot doc in doc.docs) {
        final data = doc.data()! as Map<String, dynamic>;
        VehicleOperationModel model = VehicleOperationModel.fromJson(data);

        list.add(model);
        //log('wwwwwwwwwwwwwwwwwwwwwwwwwwwww         ${model.name}');
      }
    });
    return list;
  }

  Future<List<RegisterModel>> getOperator() async {
    var list = <RegisterModel>[];
    await FirebaseFirestore.instance
        .collection(kOperatorBase)
        .get()
        .then((value) {
      for (DocumentSnapshot doc in value.docs) {
        final data = doc.data()! as Map<String, dynamic>;
        RegisterModel model = RegisterModel.fromJson(data);
        model.id = doc.id;
        list.add(model);
        log('wwwwwwwwwwwwwwwwwwwwwwwwwwwww         ${model.name}');
      }
    });
    return list;
  }

  Future<List<BookingModel>> getAllUserBookings() async {
    var list = <BookingModel>[];
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection(kStudentBase)
        .doc(user!.uid)
        .collection(kBookingList)
        .get()
        .then((valuef) async {
      for (DocumentSnapshot doc in valuef.docs) {
        final data = doc.data()! as Map<String, dynamic>;

        await FirebaseFirestore.instance
            .collection(kBookingList)
            .doc(doc.id)
            .get()
            .then((value) {
          final data = value.data()!;
          BookingModel model = BookingModel.fromJson(data);
          model.bookinRef = doc.id;

          list.add(model);
        });
      }

      /*  for (DocumentSnapshot doc in value.docs) {
        final data = doc.data()! as Map<String, dynamic>;
        RegisterModel model = RegisterModel.fromJson(data);
        model.id = doc.id;
        list.add(model);
        log('wwwwwwwwwwwwwwwwwwwwwwwwwwwww         ${model.name}');
      } */
    });
    return list;
  }

  Future<List<BookingModel>> getAllOperatorBookings() async {
    var list = <BookingModel>[];
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection(kOperatorBase)
        .doc(user!.uid)
        .collection(kBookingList)
        .get()
        .then((valuef) async {
      for (DocumentSnapshot doc in valuef.docs) {
        // final data = doc.data()! as Map<String, dynamic>;
        log('id ${doc.id}');
        await FirebaseFirestore.instance
            .collection(kBookingList)
            .doc(doc.id)
            .get()
            .then((value) {
          final data = value.data()!;
          BookingModel model = BookingModel.fromJson(data);
          model.bookinRef = doc.id;
          log('ttt $model');

          list.add(model);
        });
      }
      return list;

      /*  for (DocumentSnapshot doc in value.docs) {
        final data = doc.data()! as Map<String, dynamic>;
        RegisterModel model = RegisterModel.fromJson(data);
        model.id = doc.id;
        list.add(model);
        log('wwwwwwwwwwwwwwwwwwwwwwwwwwwww         ${model.name}');
      } */
    });
    return list;
  }
}
