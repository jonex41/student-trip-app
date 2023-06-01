import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/admin/provider/admin_provider.dart';
import 'package:student_project/data/models/booking_model.dart';
import 'package:student_project/main.dart';
import 'package:student_project/model/register_model.dart';
import 'package:student_project/utils/loader.dart';

import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../provider/booking_provider.dart';
import 'mean_detail_screen.dart';

class PickOperatorPage extends HookConsumerWidget {
  const PickOperatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operatorListProvider);
    final plugin = PaystackPlugin();
    final user = FirebaseAuth.instance.currentUser;
    final showLoaderd = useState(false);
    if (showLoaderd.value) showLoader(context);
    plugin.initialize(publicKey: publicKey);
    String _getReference() {
      String platform;
      if (Platform.isIOS) {
        platform = 'iOS';
      } else {
        platform = 'Android';
      }

      return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
    }

    void _verifyOnServer(
        String reference, ValueNotifier<bool> showlaoder) async {
      try {
        showlaoder.value = true;
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $publicKey'
        };
        http.Response response = await http.get(
            Uri.parse('https://api.paystack.co/transaction/verify/$reference'),
            headers: headers);
        final Map body = json.decode(response.body);
        log(body);
        //8051902743

        if (body['message'] == 'Invalid key') {
          BookingModel model = ref.read(bookingDetailsProvider);
          RegisterModel registerModel = ref.read(selectedOperatorProvider);
          model.driverId = registerModel.id;
          model.driverName = registerModel.name;
          model.driverStaffId = registerModel.staffId;
          model.studentName = getStringAsync(kName, defaultValue: 'John');

          FirebaseFirestore.instance
              .collection(kBookingList)
              .add(model.toJson())
              .then((value) {
            model.bookinRef = value.id;
            ref.read(bookingDetailsProvider.notifier).state = model;
            FirebaseFirestore.instance
                .collection(kStudentBase)
                .doc(user!.uid)
                .collection(kBookingList)
                .doc(value.id)
                .set({'d': 'd'}).then((valuek) {
              FirebaseFirestore.instance
                  .collection(kOperatorBase)
                  .doc(model.driverId)
                  .collection(kBookingList)
                  .doc(value.id)
                  .set({'d': 'd'}).then((value) {
                snackBar(context, title: 'Booking successful');
                showlaoder.value = false;
                hideLoader();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainDetailScreen()),
                );
              });
            }).catchError(() {
              showlaoder.value = false;
              hideLoader();
              snackBar(context, title: 'Booking failed');
            });
          }).catchError(() {
            showlaoder.value = false;
            hideLoader();
            snackBar(context, title: 'Booking failed');
          });
        }
        if (body['data']['status'] == 'success') {
          log('payment success');

          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BookingDetailsScreen()),
          ); */
          //do something with the response. show success
        } else {
          //show error prompt
        }
      } catch (e) {
        print(e);
      }
    }

    chargeCard(ValueNotifier<bool> valueNotifier) async {
      BookingModel model = ref.read(bookingDetailsProvider);
      int price = model.noPassenger! * 10000;
      Charge charge = Charge()
        ..amount = price
        ..reference = _getReference()
//..accessCode = _createAcessCode(skTest, _getReference())
        ..email = 'customer@email.com';
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
      );
      if (response.status == true) {
        _verifyOnServer(response.reference!, valueNotifier);
      } else {}
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Operator'),
        ),
        body: state.when(
            data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return ListTile(
                    onTap: (() {
                      log(data[index]);
                      ref.read(selectedOperatorProvider.notifier).state =
                          data[index];
                      chargeCard(showLoaderd);
                    }),
                    leading: CircleAvatar(
                      radius: 16.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset('assets/images/logo.jpg'),
                      ),
                    ),
                    title: Text(data[index].name ?? 'name'),
                    subtitle: Text(data[index].personId ?? 'id'),
                  );
                }),
            error: (_, __) => const Center(child: Text('An error occurred')),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
