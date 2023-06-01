import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:student_project/booking/view/booking_screen.dart';
import 'package:student_project/home/decision_page/provider/decision_provider.dart';
import 'package:student_project/home/decision_page/view/decision_page.dart';
import 'package:student_project/profile/view/profile_screen.dart';
import 'package:student_project/student_home/view/booking_history.dart';
import 'package:student_project/support/view/support_screen.dart';
import 'package:student_project/utils/constants.dart';

import '../../admin/user_location/providers/user_location_provider.dart';
import '../../model/register_model.dart';

class StudentHomePage extends HookConsumerWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void askPermission() async {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }

    useEffect(() {
      askPermission();
    });
    ref.watch(uploadLocationProvider);
    setValue(kState, kStudent);
    final user = FirebaseAuth.instance.currentUser;
    log('id user ${user!.uid}');
    String value = getStringAsync(kState);
    if (kStudent.toLowerCase().contains(value)) {
      value = kStudentBase;
    } else {
      value = kOperatorBase;
    }
    DocumentReference ref2 =
        FirebaseFirestore.instance.collection(value).doc(user.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Student'),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // popupmenu item 1
              PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: Row(
                  children: const [
                    Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Get The App")
                  ],
                ),
              ),
              // popupmenu item 2
              PopupMenuItem(
                value: 2,
                // row has two child icon and text
                child: Row(
                  children: const [
                    Icon(
                      Icons.chrome_reader_mode,
                      color: Colors.black,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("About")
                  ],
                ),
              ),

              PopupMenuItem(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  setValue(kState, "none");
                  context.pop();

                 /*  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DecisionPage()),
                  ); */
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DecisionPage()),
                  );
                },
                value: 2,
                // row has two child icon and text
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Log out")
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 55),
            color: Colors.white,
            elevation: 2,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 100.height,
            /* SizedBox(
              height: 200,
              child: const Image(
                image: AssetImage("assets/images/logo.jpg"),
              ),
            ), */
            30.height,
            Row(
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    ref.read(decisionProvider.notifier).state = kStudent;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  child: StreamBuilder<RegisterModel>(
                      stream: ref2.snapshots().map((event) =>
                          RegisterModel.fromJson(
                              event.data() as Map<String, dynamic>)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          RegisterModel data = snapshot.data!;
                           setValue(kName, data.name);
                           
                          return Container(
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: data.urlImage == null
                                        ? Image.asset(
                                            'assets/images/profile.png',
                                            width: 150.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            data.urlImage!,
                                            width: 150.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 180,
                                    decoration: const BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12))),
                                    padding: const EdgeInsets.all(12),
                                    child: const Text("Profile",
                                        style: TextStyle(color: white)),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(
                                    'assets/images/profile.png',
                                    width: 150.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 180,
                                  decoration: const BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12))),
                                  padding: const EdgeInsets.all(12),
                                  child: const Text("Profile",
                                      style: TextStyle(color: white)),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                10.width,
                InkWell(
                  onTap: () {
                    ref.read(decisionProvider.notifier).state = kOperator;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingScreen()),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              'assets/images/vehicle_3.jpg',
                              width: 150.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            width: 180,
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12))),
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              "Book trip",
                              style: TextStyle(color: white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /*  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child:
                            Icon(Icons.person, size: 24, color: Colors.blueAccent),
                        padding: const EdgeInsets.all(12),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12))),
                        child: Text("Student"),
                        padding: const EdgeInsets.all(12),
                      )
                    ],
                  ),
                ),
                10.width,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child:
                            Icon(Icons.person, size: 24, color: Colors.blueAccent),
                        padding: const EdgeInsets.all(12),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12))),
                        child: Text("Student"),
                        padding: const EdgeInsets.all(12),
                      )
                    ],
                  ),
                )
 */
                /*  InkWell(
                  onTap: () {
                     ref.read(decisionProvider.notifier).state = kStudent;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                    // print('button Pressed');
                    // Call your onPressed or onTap function here
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    height: 200,
                    width: 150,
                    child: const Text(
                      'Student',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                10.width,
                InkWell(
                  onTap: () {
                    ref.read(decisionProvider.notifier).state = kOperator;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    height: 200,
                    width: 150,
                    child: const Text(
                      'Operator',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
               */
              ],
            ),
            20.height,
            Row(
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    ref.read(decisionProvider.notifier).state = kStudent;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookingHistory()),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              'assets/images/vehicle_2.png',
                              width: 150.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            width: 180,
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12))),
                            padding: const EdgeInsets.all(12),
                            child: const Text("Booking History",
                                style: TextStyle(color: white)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                10.width,
                InkWell(
                  onTap: () {
                    ref.read(decisionProvider.notifier).state = kOperator;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportScreen()),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              'assets/images/admin_1.jpg',
                              width: 150.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            width: 180,
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12))),
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              "Support",
                              style: TextStyle(color: white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /*  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child:
                            Icon(Icons.person, size: 24, color: Colors.blueAccent),
                        padding: const EdgeInsets.all(12),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12))),
                        child: Text("Student"),
                        padding: const EdgeInsets.all(12),
                      )
                    ],
                  ),
                ),
                10.width,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child:
                            Icon(Icons.person, size: 24, color: Colors.blueAccent),
                        padding: const EdgeInsets.all(12),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12))),
                        child: Text("Student"),
                        padding: const EdgeInsets.all(12),
                      )
                    ],
                  ),
                )
 */
                /*  InkWell(
                  onTap: () {
                     ref.read(decisionProvider.notifier).state = kStudent;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                    // print('button Pressed');
                    // Call your onPressed or onTap function here
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    height: 200,
                    width: 150,
                    child: const Text(
                      'Student',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                10.width,
                InkWell(
                  onTap: () {
                    ref.read(decisionProvider.notifier).state = kOperator;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    height: 200,
                    width: 150,
                    child: const Text(
                      'Operator',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
               */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
