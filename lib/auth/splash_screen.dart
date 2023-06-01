import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/admin/view/admin_page.dart';
import 'package:student_project/auth/authentication_screen.dart';

import 'package:student_project/auth/custom_loader.dart';
import 'package:student_project/auth/globals.dart';
import 'package:student_project/auth/operator_home/view/home_operator.dart';
import 'package:student_project/home/decision_page/view/decision_page.dart';
import 'package:student_project/home/view/home_screen.dart';
import 'package:student_project/utils/constants.dart';

import '../home/decision_page/provider/decision_provider.dart';
import '../student_home/view/student_home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const id = 'SplashScreen';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String state = getStringAsync(kState);
    Future.delayed(Duration.zero, () {
      if (user != null) {
        //final state = ref.read(decisionProvider);

        if (state == kStudent) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const StudentHomePage(),
                settings: RouteSettings(name: "/student")),
          );
        } else if (state == kOperator) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OperatorHomePage()),
          );
        }
      } else {
        if (state == kAdmin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DecisionPage()),
          );
        }
      }
    });

    return const SafeArea(
      child: Scaffold(
        body: CustomLoader(),
      ),
    );
  }
}
