import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/admin/view/student_user_list.dart';
import 'package:student_project/admin/view/ticket_datails_page.dart';
import 'package:student_project/admin/view/vehicles_operation.dart';
import 'package:student_project/admin/view/weekly_report.dart';
import 'package:student_project/utils/constants.dart';

import '../../home/decision_page/view/decision_page.dart';
import 'operator_user_list.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (contextl) => [
              PopupMenuItem(
                value: 1,
                onTap: () {
                  context.pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WeeklyReportPage()),
                  );
                },
                // row has two child icon and text.
                child: Row(
                  children: const [
                    Icon(
                      Icons.car_repair_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Weekly Report")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                onTap: () {
                  context.pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VehiclesOperation()),
                  );
                },
                // row has two child icon and text.
                child: Row(
                  children: const [
                    Icon(
                      Icons.car_repair_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Vehicles Operation")
                  ],
                ),
              ),

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
                value: 2,
                // row has two child icon and text
                onTap: () {
                  setValue(kState, "none");
                  context.pop();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DecisionPage()),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DecisionPage()),
                  );
                },
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*  SizedBox(
            height: 50,
            child: const Image(
              image: AssetImage("assets/images/logo.jpg"),
            ),
          ), */

          Row(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  //UserLocationPage()
                  // ref.read(decisionProvider.notifier).state = kStudent;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudentUserPage()),
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
                            'assets/images/student3.jpg',
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
                          child: const Text("Student Users",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OperatorUserPage()),
                  );
                  // ref.read(decisionProvider.notifier).state = kOperator;
                  /*   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OperatorHomePage()),
                  ); */
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
                        child: Image.asset(
                          'assets/images/campus_cap.jpg',
                          width: 150.0,
                          height: 100.0,
                          fit: BoxFit.cover,
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
                            "Operator Users",
                            style: TextStyle(color: white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          15.height,
          10.width,
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TicketDetails()),
              );
              // ref.read(decisionProvider.notifier).state = kOperator;
              /*   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OperatorHomePage()),
                  ); */
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
                        'assets/images/vahicle_new.jpg',
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
                        "Ticket Details",
                        style: TextStyle(color: white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
