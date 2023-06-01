import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

import 'package:student_project/admin/provider/admin_provider.dart';
import 'package:student_project/auth/helpers.dart';
import 'package:student_project/utils/constants.dart';
import 'package:student_project/utils/loader.dart';

import 'change_booking.dart';

class BookingHistory extends HookConsumerWidget with WidgetsBindingObserver {
  const BookingHistory({super.key});
  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingListProvider);
    final user = FirebaseAuth.instance.currentUser;
    useEffect(() {
      WidgetsBinding.instance.addObserver(this);
      return () {
        WidgetsBinding.instance.removeObserver(this);
      };
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking History '),
        ),
        body: state.when(
            data: (data) {
              if (data.isNotEmpty) {
                data.sort((a, b) => b.date!.compareTo(a.date!));
              }

              return data.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ListTile(
                          minLeadingWidth: 0,
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CancelBookingPage(
                                        model: data[index],
                                      )),
                            );
                          }),
                          leading: CircleAvatar(
                            radius: 16.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset('assets/images/logo.jpg'),
                            ),
                          ),
                          title: Align(
                              alignment: const Alignment(-1.1, 0),
                              child: Text(data[index].bookinRef!)),
                          subtitle: Align(
                            alignment: const Alignment(-1.1, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Dest: '),
                                Text(
                                  data[index].destination!,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                          trailing: ElevatedButton(
                              onPressed: () {
                                if (data[index].progress == kCompleted) {
                                  showSnackBar('Trip Already completed');
                                } else {
                                  showInDialog(context,
                                      builder: (context) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                  'Please select your status'),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    context.pop();

                                                    showLoader(context);
                                                    await FirebaseFirestore
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
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            kProgTripBase)
                                                        .doc(user!.uid)
                                                        .set({
                                                      kSLat: data[index].latS,
                                                      kSLong: data[index].longS,
                                                      kDLat: data[index].latD,
                                                      kDLong: data[index].longD
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            kBookingList)
                                                        .doc(data[index]
                                                            .bookinRef)
                                                        .set(
                                                            {
                                                          'progress':
                                                              kInProgress
                                                        },
                                                            SetOptions(
                                                                merge:
                                                                    true)).then(
                                                            (value) {
                                                      ref.refresh(
                                                          bookingListProvider);
                                                      hideLoader();
                                                    });
                                                  },
                                                  child:
                                                      const Text('inProgress')),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    context.pop();
                                                    showLoader(context);
                                                    log(' hhhhhhh  ${data[index].driverId}');
                                                    String id =
                                                        data[index].driverId!;
                                                    log('lllll $id');
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            kProgTripBase)
                                                        .doc(data[index]
                                                            .driverId)
                                                        .delete();
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            kProgTripBase)
                                                        .doc(user!.uid)
                                                        .delete();
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            kOperatorBase)
                                                        .doc(id)
                                                        .get()
                                                        .then((docUser) async {
                                                      final dataw =
                                                          docUser.data()!;
                                                      String? counts =
                                                          dataw[kCount];
                                                      int realCountw =
                                                          int.parse(counts ??
                                                                  '0') +
                                                              1;
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              kOperatorBase)
                                                          .doc(id)
                                                          .set(
                                                              {
                                                            kCount: realCountw
                                                                .toString()
                                                          },
                                                              SetOptions(
                                                                  merge:
                                                                      true)).then(
                                                              (value) async {
                                                        final user =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                kStudentBase)
                                                            .doc(user!.uid)
                                                            .get()
                                                            .then(
                                                                (docUser) async {
                                                          final dataw =
                                                              docUser.data()!;
                                                          String? counts =
                                                              dataw[kCount];
                                                          int realCountw =
                                                              int.parse(
                                                                      counts ??
                                                                          '0') +
                                                                  1;
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  kStudentBase)
                                                              .doc(user.uid)
                                                              .set(
                                                                  {
                                                                kCount: realCountw
                                                                    .toString()
                                                              },
                                                                  SetOptions(
                                                                      merge:
                                                                          true)).then(
                                                                  (value) async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    kVehicles)
                                                                .doc(id)
                                                                .get()
                                                                .then(
                                                                    (value) async {
                                                              final dataw =
                                                                  value.data()!;
                                                              String? counts =
                                                                  dataw[kCount];
                                                              int realCount =
                                                                  int.parse(counts ??
                                                                          '0') +
                                                                      1;
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      kVehicles)
                                                                  .doc(id)
                                                                  .set(
                                                                      {
                                                                    kCount: realCount
                                                                        .toString()
                                                                  },
                                                                      SetOptions(
                                                                          merge:
                                                                              true)).then(
                                                                      (value) async {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        kBookingList)
                                                                    .doc(data[
                                                                            index]
                                                                        .bookinRef)
                                                                    .set({
                                                                  'progress':
                                                                      kCompleted
                                                                }, SetOptions(merge: true)).then(
                                                                        (value) {
                                                                  ref.refresh(
                                                                      bookingListProvider);
                                                                  hideLoader();
                                                                });
                                                              });
                                                            });
                                                          });
                                                        });
                                                      });
                                                    });
                                                  },
                                                  child:
                                                      const Text('Completed')),
                                            ],
                                          ),
                                      dialogAnimation:
                                          DialogAnimation.SLIDE_BOTTOM_TOP);
                                }
                              },
                              child: Text(data[index].progress ?? 'Waiting')),
                        );
                      })
                  : Center(
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 100,
                          child: Image(
                            image: AssetImage("assets/images/logo.jpg"),
                          ),
                        ),
                        10.height,
                        const Text('No bookings yet'),
                      ],
                    ));
            },
            error: (_, __) => const Center(child: Text('An error occurred')),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
