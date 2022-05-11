import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handshake/components/form_input.dart';
import 'package:handshake/components/options.dart' as options;
import 'package:handshake/components/reusable_button.dart';
import 'package:handshake/data/models/responses/access_token_model.dart';
import 'package:handshake/data/models/responses/user_model.dart';
import 'package:handshake/data/repository/app_repository.dart';
import 'package:handshake/data/repository/session.dart';
import 'package:handshake/utils/function_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File? photo;
  String file = '';
  String code = '';

  Future pickImage(ImageSource source) async {
    try {
      final photo = await ImagePicker().getImage(source: source);
      if (photo == null) return;
      final imageTemporary = File(photo.path);
      setState(() {
        this.photo = imageTemporary;
        file = photo.path;
        print(file);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController nextOfK1Controller = TextEditingController();
  TextEditingController nextOfK2Controller = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  bool isBusiness = false, isVehicle = false;

  @override
  Widget build(BuildContext context) {
    code = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kwhite,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Create a profile',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: kblack),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, "/otp");
          },
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: kblack,
            size: 30,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 46,
                      backgroundColor: kblue,
                      child: CircleAvatar(
                        backgroundColor: kblue,
                        backgroundImage: photo != null
                            ? FileImage(
                                photo!,
                              )
                            : const AssetImage(
                                'assets/avatar.png',
                              ) as ImageProvider,
                        radius: 45,
                      ),
                    ),
                    onTap: () {
                      pickImage(ImageSource.camera);
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Allow camera permission to capture your face directly',
                    style: ksubheading,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormInput('Full Name', fullNameController),
                  FormInput('Address', addressController),
                  FormInput('Email Address', emailAddressController),
                  FormInput(
                      'Next of Kin\'s Whatsapp Number 1', nextOfK1Controller,hint: '+2348XXXXXXXXX'),
                  FormInput(
                      'Next of Kin\'s Whatsapp Number 2', nextOfK2Controller,hint: '+2348XXXXXXXXX'),
                  const Text(
                    'Do you have a business?',
                    style: ksubheading,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  options.Options(
                    onValueChanged: (String value) {
                      Logger().i('value is $value');
                      isBusiness = value == 'Yes';
                      setState(() {

                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                     visible: ( isBusiness ),
                      child: FormInput('Business Name', businessNameController)),
                  Visibility(
                    visible: (isBusiness),
                      child: FormInput('Business Address', businessAddressController)),
                  Text(
                    'Do you use your vehicle for Transportation?',
                    style: ksubheading,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  options.Options(
                    onValueChanged: (String value) {
                      Logger().i('value is $value');
                      isVehicle = value == 'Yes';
                      setState(() {

                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: (isVehicle),
                      child: FormInput('Vehicle\'s Plate Number', vehicleController)),
                  SizedBox(
                    height: 40,
                  ),
                  OtherButton(
                      onPressedFunction: () {
                        _register(context);
                      },
                      label: 'Register'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _register(BuildContext context) {
    FocusManager.instance.primaryFocus!.unfocus();
    var name = fullNameController.text;
    var address = addressController.text;
    var email = emailAddressController.text;
    var num1 = nextOfK1Controller.text;
    var num2 = nextOfK2Controller.text;
    var businessName = businessNameController.text;
    var businessAddress = businessAddressController.text;
    var plateNo = vehicleController.text;
    if (photo == null ) {
      FunctionUtils.showSnackBar(context, "Pix is Compulsory");
      return;
    }
    if (photo == null ||
        name.isEmpty ||
        address.isEmpty ||
        email.isEmpty ||
        num1.isEmpty ||
        num2.isEmpty ||
        (isBusiness && (businessName.isEmpty || businessAddress.isEmpty)) ||
        (isVehicle && plateNo.isEmpty)) {
      FunctionUtils.showSnackBar(context, "Please fill up all information");
      return;
    }

    var client = AppRepository.instance.getRetrofitClient;
    var loadingDialog = FunctionUtils.prepareLoadingDialog(context);
    loadingDialog.show();
    client
        .createAccount(name, email, address, code, num1, num2, isBusiness,
            businessName, businessAddress, isVehicle, plateNo, photo!)
        .then((value) async {
      Logger().i(value);
      loadingDialog.hide();
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
          response['data']['token'] != null) {
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
          break;
      }
    });
  }
}
