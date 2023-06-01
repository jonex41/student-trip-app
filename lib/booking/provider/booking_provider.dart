import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_project/booking/view/booking_details_screen.dart';
import 'package:student_project/data/models/booking_model.dart';
import 'package:student_project/model/register_model.dart';
import 'package:student_project/utils/constants.dart';

final dateProvider = StateProvider<String>((ref) {
  return 'Departure Date';
});

final timeProvider = StateProvider<String>((ref) {
  return 'Departure Time';
});

final bookingDetailsProvider = StateProvider<BookingModel>((ref) {
  return  BookingModel(
      source: '',
      destination: '',
      departureDate: '',
      departureTime: '',
      bookinRef: '',
      latS: 0,
      longD: 0,
      latD: 0,
      longS: 0,
      progress: kWaiting,
      date: DateTime.now().toString(),
        time: TimeOfDay.now().toString(),
      noPassenger: 0);
});

final selectedOperatorProvider = StateProvider<RegisterModel>((ref) {
  return  RegisterModel(
      name: '',
      registrationNo: '',
      phone: '',
      address: '',
      department: '',
      password: '',
      departmentId: '',
      personId: '',
      gender: '',
      urlImage: '',
      email: '',
      count: '0',
      staffId: '',
      studentId: '',
      vehicleId: '');
});
