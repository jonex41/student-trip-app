import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:student_project/model/vehicle_operation_model.dart';
import 'package:student_project/utils/constants.dart';

class VeicleOperationFormBloc extends FormBloc<String, String> {
  // final ApiRepository _apiRepository;
  final trip_in_progress = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final vehicle_in_que = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final completed_trips = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
  final cummuter_statistics = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  final destination = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );
  final dailly_no_of_trip = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,

      //  FieldBlocValidators.email,
    ],
  );

  /*   final confirmPassword = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
   Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return 'password does not match';
    };
  } */

  VeicleOperationFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        trip_in_progress,
        vehicle_in_que,
        completed_trips,
        cummuter_statistics,
        destination,
        dailly_no_of_trip,
      ],
    );

    // return super(null);
  }

  @override
  void onSubmitting() async {
    try {
      VehicleOperationModel model = VehicleOperationModel(
        trip_in_progress: trip_in_progress.value,
        vehicle_in_queue: vehicle_in_que.value,
        completed_trips: completed_trips.value,
        cummuter_statistics: cummuter_statistics.value,
        destination: destination.value,
        daily_no_trip: dailly_no_of_trip.value,
        date: DateTime.now().toString(),
        time: TimeOfDay.now().toString()
      );

      FirebaseFirestore.instance
          .collection(kTripDetails)
          .add(model.toJson())
          .then((value) {
        emitSuccess(successResponse: "res");
      }).catchError(() {
        emitFailure(failureResponse: "Upload Failed");
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
