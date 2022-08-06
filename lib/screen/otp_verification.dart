import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handshake/components/reusable_button.dart';
import 'package:handshake/data/models/responses/access_token_model.dart';
import 'package:handshake/data/models/responses/user_model.dart';
import 'package:handshake/data/repository/app_repository.dart';
import 'package:handshake/data/repository/session.dart';
import 'package:handshake/utils/function_utils.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var pinCode = '';
  var phone = '';

  @override
  Widget build(BuildContext context) {
    phone = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        title: const Text(
          'OTP Verification',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: kblack),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, "/auth");
          },
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: kblack,
            size: 30,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 33,
              ),
              Center(
                child: Container(
                    width: 135,
                    height: 18,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/anti.png"),
                          fit: BoxFit.fill),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Row(
                children: [
                  const Text(
                    'Enter the verification code sent to ',
                    style: ksubheading,
                  ),
                  Text(
                    '+234$phone',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: kblack),
                  )
                ],
              )),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 30,
              ),
              PinCodeTextField(
                appContext: context,
                pastedTextStyle: const TextStyle(
                  color: inputColor,
                  fontWeight: FontWeight.bold,
                ),
                length: 5,
                obscureText: true,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 4) {
                    return "Too short pin code";
                  } else {
                    return null;
                  }
                },
                enablePinAutofill: true,

                pinTheme: PinTheme(
                  inactiveColor: inputColor,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(50),
                  selectedFillColor: inputColor,
                  errorBorderColor: inputColor,
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: inputColor,
                  inactiveFillColor: inputColor,
                  activeColor: inputColor,
                  disabledColor: inputColor,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                keyboardType: TextInputType.text,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  pinCode = v;
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  pinCode = value;
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              OtherButton(
                  onPressedFunction: () {
                    _verifyCode(context);
                  },
                  label: 'Verify'),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Didn\'t receive code? ',
                      style: ksubheading,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _sendCode(context);
                    },
                    child: const Text('Resend', style: kblkheading),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyCode(BuildContext context) {
    FocusManager.instance.primaryFocus!.unfocus();
    var client = AppRepository.instance.getRetrofitClient;
    if (pinCode.length != 5) {
      FunctionUtils.showSnackBar(context, "Invalid code");
      return;
    }
    var loadingDialog = FunctionUtils.prepareLoadingDialog(context);
    loadingDialog.show();
    client.verifyOtpCode(phone, pinCode).then((value) async {
      loadingDialog.hide();
      //Logger().i(value);
      var response = jsonDecode(value);
      if (response != null && response['message'] != null) {
        FunctionUtils.showSnackBar(context, "${response['message']}");
      }
      if (response != null && response['statusCode'] != 200) {
        return;
      }
      if (response != null &&
          response['data'] != null &&
          response['data']['user'] != null &&
          response['data']['user']['create_account'] == true) {
        Navigator.popAndPushNamed(context, "/completeprofile",
            arguments: pinCode);
      } else if (response != null &&
          response['data'] != null &&
          response['data']['user'] != null &&
          response['data']['user']['create_account'] == false) {
        // Logger().i(response['data']['user']);
        // Logger().i(response['data']['token']);
        SessionManager.instance.user = User.fromJson(response['data']['user']);
        SessionManager.instance.token =
            AccessToken(token: response['data']['token']);
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString(
            loggedInUserResponse, jsonEncode(SessionManager.instance.user));
        await pref.setString(token, response['data']['token']);
        Navigator.popAndPushNamed(context, "/home");
      }
    }).catchError((Object obj) {
      // non-200 error goes here.
      loadingDialog.hide();
      FunctionUtils.showSnackBar(context, "Try again");
      Logger().i(obj);
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          Logger().e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
          Logger().e("Got error : $obj");
          break;
      }
    });
  }

  void _sendCode(BuildContext context) {
    FocusManager.instance.primaryFocus!.unfocus();
    var client = AppRepository.instance.getRetrofitClient;
    if (phone.isEmpty) {
      Navigator.pop(context);
      return;
    }
    var loadingDialog = FunctionUtils.prepareLoadingDialog(context);
    loadingDialog.show();
    client.requestVerificationCode(phone).then((value) {
      loadingDialog.hide();
      var response = jsonDecode(value);
      if (response != null && response['message'] != null) {
        FunctionUtils.showSnackBar(context, "${response['message']}");
      }
    }).catchError((Object obj) {
      // non-200 error goes here.
      loadingDialog.hide();
      FunctionUtils.showSnackBar(context, "Try again");
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          Logger().e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
          break;
      }
    });
  }
}
