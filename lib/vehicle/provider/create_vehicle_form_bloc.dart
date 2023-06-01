import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/model/vehicle_model.dart';
import 'package:student_project/utils/constants.dart';

class VehicleFormBloc extends FormBloc<String, String> {
  // final ApiRepository _apiRepository;

  final id = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final ownerId = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
  final name = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final model = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

    final address = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
final phoneNumber = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
  final type = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final plate_number = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final capacity = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  VehicleFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        id,
        ownerId,
        name,
        model,
        type,
        plate_number,
        capacity,
        address,
        phoneNumber
      ],
    );

    // return super(null);
  }

  @override
  void onSubmitting() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final vehicleModel = VehicleModel(
        uId: user!.uid,
        id: id.value,
        ownderId: ownerId.value,
        name: name.value,
        model: model.value,
        type: type.value,
        count: '0',
        phoneNumber: phoneNumber.value,
        address: address.value,
        imageUrl: getStringAsync("vehicleImage"),
        date: DateTime.now().toIso8601String(),
        plateNumber: plate_number.value,
        capacity: capacity.value,
      );

      FirebaseFirestore.instance
          .collection(kVehicles)
          .doc(user.uid)
          .set(vehicleModel.toJson())
          .then((value) {
        emitSuccess();
      }).catchError(() {
        emitFailure();
      });
    } catch (e) {
      //  logger.d(e);
      //   print(' an error is occuring ohhh');
      /*    if (e is LogInWithEmailAndPasswordFailure) {
        emitFailure(failureResponse: e.message);
      } else */
      if (e == 'username-not-found') {
        emitFailure(failureResponse: 'Account does not exist!');
      } else {
        emitFailure(failureResponse: e.toString());
      }
    }
    //    emitFailure(failureResponse: 'This is an awesome error!');
  }
}
