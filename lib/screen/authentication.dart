import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handshake/components/reusable_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:handshake/data/repository/app_repository.dart';
import 'package:handshake/utils/function_utils.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isTocAccepted = false;

  @override
  void initState() {
    _isTocAccepted = false;
    super.initState();
  }

  void _onCountryChange(CountryCode countryCode) {
    print("country code " + countryCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        title: const Text(
          'Enter your number',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: kblack),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop();
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
              const Center(
                  child: Text(
                'Anti-kidnap will need to verify your number',
                style: ksubheading,
              )),
              const SizedBox(
                height: 50,
              ),
              // FormInput(
              //   'Country',
              //   loginController,
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // FormInput(
              //   'Phone number',
              //   loginController,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Country",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: kblue),
                        color: inputColor),
                    child: CountryCodePicker(
                      showDropDownButton: true,
                      backgroundColor: kwhite,
                      flagWidth: 20,
                      boxDecoration: const BoxDecoration(),
                      onChanged: _onCountryChange,
                      initialSelection: 'NG',
                      favorite: ['+234', 'NG'],
                      // optional. Shows only country name and flag
                      showCountryOnly: true,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: true,
                      showFlag: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: true,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Phone number",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: kblue),
                        color: inputColor),
                    child: Row(
                      children: [
                        CountryCodePicker(
                          showDropDownButton: true,
                          flagWidth: 20,
                          flagDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          onChanged: _onCountryChange,
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: 'NG',
                          favorite: ['+234', 'NG'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            cursorColor: kblack,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(width: 2.0, color: kblue),
                    ),
                    checkColor: Colors.lightBlueAccent,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: _isTocAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        _isTocAccepted = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'I have read and accepted ',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'www.antikidnap.com',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.lightBlueAccent,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await launch('http://www.antikidnap.com');
                              },
                          ),
                          const TextSpan(text: ' Terms and Conditions'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              OtherButton(
                  onPressedFunction: () {
                    _sendCode(context);
                  },
                  label: 'Continue')
            ],
          ),
        ),
      ),
    );
  }

  void _sendCode(BuildContext context) {
    FocusManager.instance.primaryFocus!.unfocus();
    if (!_isTocAccepted) {
      FunctionUtils.showSnackBar(
          context, 'You need to accept Terms and Condition first');
      return;
    }
    var client = AppRepository.instance.getRetrofitClient;
    var phone = _phoneController.text;
    if (phone.isEmpty) {
      FunctionUtils.showSnackBar(context, "Phone number can not be empty");
      return;
    }
    var loadingDialog = FunctionUtils.prepareLoadingDialog(context);
    loadingDialog.show();
    client.requestVerificationCode(phone).then((value) {
      loadingDialog.hide();
      Logger().d("Got result : $value");
      var response = jsonDecode(value);
      if (response != null && response['message'] != null) {
        FunctionUtils.showSnackBar(context, "${response['message']}");
      }
      if (response != null && response['statusCode'] != 200) {
        return;
      }
      Navigator.popAndPushNamed(context, "/otp", arguments: phone);
    }).catchError((Object obj) {
      // non-200 error goes here.
      loadingDialog.hide();
      Logger().i(obj);
      FunctionUtils.showSnackBar(context, "Try again");
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          Logger().e(
              "Got error : ${res?.statusCode} -> ${res?.statusMessage}\n ${res?.data}");
          break;
        default:
          Logger().e("Got error : ${obj}");
          break;
      }
    });
  }
}
