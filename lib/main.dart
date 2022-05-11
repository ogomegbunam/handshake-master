



import 'package:flutter/material.dart';

import 'package:handshake/screen/authentication.dart';
import 'package:handshake/screen/complete_profile.dart';
import 'package:handshake/screen/confirm_handshake.dart';
import 'package:handshake/screen/congratulations.dart';
import 'package:handshake/screen/home_screen.dart';
import 'package:handshake/screen/otp_verification.dart';
import 'package:handshake/screen/qr_code_screen.dart';
import 'package:handshake/screen/splash_screen.dart';
import 'package:handshake/screen/update_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/auth": (ctx) => Authentication(),
        "/otp": (ctx) => const OtpVerification(),
        "/completeprofile": (ctx) => const CompleteProfile(),
        "/home": (ctx) => Homescreen(),
        "/hand-shake": (ctx) => ConfirmHandShake(),
        "/update-profile": (ctx) => const UpdateProfile(),
        "/success": (ctx) => const CustomDailog(),
        "/qr-code": (ctx) => const QrCodeScreen(),
      },
      home: Authentication(),
    );
  }
}
