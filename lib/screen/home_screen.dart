import 'package:flutter/material.dart';
import 'package:handshake/components/home_button.dart';
import 'package:handshake/data/repository/session.dart';
import 'package:handshake/utils/function_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class Homescreen extends StatelessWidget {
  Homescreen({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage("assets/home.png"),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              fit: BoxFit.fill),
          color: Colors.black,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeButton(
                    onpressedfunction: () {
                      Navigator.pushNamed(context, "/qr-code");
                    },
                    label: 'Handshake for Security',
                    asset: 'assets/camera.svg'),
                SizedBox(
                  height: 20,
                ),
                HomeButton(
                    onpressedfunction: () {
                      _raiseAlarm(context, "alarm_1");
                    },
                    label: '      Raise alarm1',
                    asset: 'assets/notification.svg'),
                SizedBox(
                  height: 20,
                ),
                HomeButton(
                    onpressedfunction: () {
                      _raiseAlarm(context, "alarm_2");
                    },
                    label: '      Raise alarm2',
                    asset: 'assets/notification.svg'),
                SizedBox(
                  height: 20,
                ),
                HomeButton(
                    onpressedfunction: () {
                      Navigator.pushNamed(context, "/update-profile");
                    },
                    label: '      Update Profile',
                    asset: 'assets/profile.svg'),
                SizedBox(
                  height: 20,
                ),
                HomeButton(
                    onpressedfunction: () async {
                      var url = 'http://antikidnap.com/contact';
                      launch(url);
                    },
                    label: '    Handshake History ',
                    asset: 'assets/document.svg'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _raiseAlarm(BuildContext context, String alarm_type) async {
    FocusManager.instance.primaryFocus!.unfocus();
    String url;
    String text =
        'Your friend ${SessionManager.instance.user!.full_name} has pressed A distress Alarm button on AntiKidnap App. Try to reach him/her through mobile calls, and contact relatives. AntiKidnap suggests you validate this message before raising an alarm.';
    if (alarm_type == 'alarm_1') {
      url =
          "https://wa.me/${SessionManager.instance.user!.nok_phone_number}?text=$text";
    } else {
      url =
          "https://wa.me/${SessionManager.instance.user!.nok_alternate_phone_number}?text=$text";
    }
    try {
      await launch(url);
    } catch (e) {
      FunctionUtils.showSnackBar(context, 'Failed to raise alarm');
    }

    // var client = AppRepository.instance.getRetrofitClient;
    //
    // var loadingDialog = FunctionUtils.prepareLoadingDialog(context);
    // var token = SessionManager.instance.token;
    // if (token == null) {
    //   FunctionUtils.showSnackBar(context, 'Operation failed');
    //   return;
    // }
    //
    // loadingDialog.show();
    // client.raiseAlarm(token.bearerToken(), alarm_type).then((value) {
    //   loadingDialog.hide();
    //   Logger().d("Got result : $value");
    //   FunctionUtils.showSnackBar(context, 'Success');
    // }).catchError((Object obj) {
    //   // non-200 error goes here.
    //   loadingDialog.hide();
    //   FunctionUtils.showSnackBar(context, "Failed");
    //   switch (obj.runtimeType) {
    //     case DioError:
    //       // Here's the sample to get the failed response error code and message
    //       final res = (obj as DioError).response;
    //       Logger().e(
    //           "Got error : ${res?.statusCode} -> ${res?.statusMessage}\n ${res?.data}");
    //       break;
    //     default:
    //       Logger().e("Got error : ${obj}");
    //       break;
    //   }
    // });
  }
}
