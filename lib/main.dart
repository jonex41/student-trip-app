import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/auth/splash_screen.dart';
import 'package:student_project/home/decision_page/view/decision_page.dart';
import 'package:student_project/signin_page/view/sign_screen.dart';

import 'auth/globals.dart';

var publicKey = 'pk_test_f7b388a9d0a2421e287ade5c353b42e34e05196c';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialize();

  final plugin = PaystackPlugin();
  plugin.initialize(publicKey: publicKey);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Globals.scaffoldMessengerKey,
        theme: ThemeData(
        
          primarySwatch: Colors.blue,
        ),
        home:  SplashScreen(),
      ),
    );
  }
}
