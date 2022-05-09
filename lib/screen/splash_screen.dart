import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:handshake/constants.dart';
import 'package:handshake/data/models/responses/access_token_model.dart';
import 'package:handshake/data/models/responses/user_model.dart';
import 'package:handshake/data/repository/session.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      checkAndNavigate();
      // Navigator.of(context)
      //     .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: 279,
                  height: 279,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.fill),
                  )),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: primaryColor,
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         // logo here
    //         Image.asset(
    //           'assets/onboard/Shapes-Overlay.png',
    //           height: 120,
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         CircularProgressIndicator(
    //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  void checkAndNavigate() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      var userResponseStr = _prefs.getString(loggedInUserResponse) ?? "";
      var tokenResponseStr = _prefs.getString(token) ?? "";
      Logger().i(userResponseStr);
      Logger().i(tokenResponseStr);

      if (userResponseStr == "" || tokenResponseStr == "") {
        Navigator.pushReplacementNamed(context, "/auth");
        return;
      }

      var response = jsonDecode(userResponseStr);
      SessionManager.instance.user = User.fromJson(response);
      SessionManager.instance.token = AccessToken(token: tokenResponseStr);
      Navigator.pushReplacementNamed(context, "/home");
    } catch (error) {
      Logger().i(error);
      Navigator.pushReplacementNamed(context, "/auth");
    }
  }
}
