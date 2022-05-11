import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handshake/components/form_input.dart';
import 'package:handshake/components/options.dart' as options;
import 'package:handshake/components/reusable_button.dart';
import 'package:handshake/data/models/responses/access_token_model.dart';
import 'package:handshake/data/models/responses/user_model.dart';
import 'package:handshake/data/models/responses/user_model2.dart';
import 'package:handshake/data/repository/app_repository.dart';
import 'package:handshake/data/repository/session.dart';
import 'package:handshake/utils/function_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String file = '';
  String code = '';
  User? user;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nextOfK1Controller = TextEditingController();
  TextEditingController nextOfK2Controller = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();

  @override
  void initState() {
    user = SessionManager.instance.user;
    if (user != null) {
      fullNameController.text = user!.full_name;
      addressController.text = user!.address;
      nextOfK1Controller.text = user!.nok_phone_number;
      nextOfK2Controller.text = user!.nok_alternate_phone_number;
      businessNameController.text = user!.business_name ?? "";
      businessAddressController.text = user!.business_address ?? "";
      vehicleController.text = user!.vehicle_plate_number ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kwhite,
      // appBar: AppBar(
      //   backgroundColor: kblue,
      //   title: const Text(
      //     'Update profile',
      //     style: TextStyle(
      //         fontWeight: FontWeight.w600, fontSize: 18, color: kblack),
      //   ),
      //   centerTitle: true,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: const Icon(
      //       Icons.keyboard_arrow_left,
      //       color: kblack,
      //       size: 30,
      //     ),
      //   ),
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage("assets/background.png"),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.color),
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_left,
                          color: kwhite,
                          size: 30,
                        ),
                      ),
                      Text(
                        'Update profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: kwhite),
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  CircleAvatar(
                    radius: 46,
                    backgroundColor: kwhite,
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(85.0),
                      child: user != null && user!.avatar.isNotEmpty
                          ? CachedNetworkImage(
                              height: 85,
                              width: 85,
                              fit: BoxFit.cover,
                              imageUrl: user!.avatar,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : Image.asset(
                              "assets/avatar.png",
                              height: 70,
                              width: 70,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  const Text(
                    '',
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
                  FormInput(
                    'Next of Kin\'s Whatsapp Number 1',
                    nextOfK1Controller,
                    hint: '+2348XXXXXXXXX',
                  ),
                  FormInput(
                    'Next of Kin\'s Whatsapp Number 2',
                    nextOfK2Controller,
                    hint: '+2348XXXXXXXXX',
                  ),
                  FormInput('Business Name', businessNameController),
                  FormInput('Business Address', businessAddressController),
                  FormInput('Vehicle\'s Plate Number', vehicleController),
                  SizedBox(
                    height: 40,
                  ),
                  OtherButton(
                      onPressedFunction: () {
                        _register(context);
                      },
                      label: 'Update'),
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
    var num1 = nextOfK1Controller.text;
    var num2 = nextOfK2Controller.text;
    var businessName = businessNameController.text;
    var businessAddress = businessAddressController.text;
    var plateNo = vehicleController.text;
    if (name.isEmpty) {
      FunctionUtils.showSnackBar(context, "Please fill up your name");
      return;
    }
    if (address.isEmpty) {
      FunctionUtils.showSnackBar(context, "Please kindly fill your address");
      return;
    }
    if (num1.isEmpty || num2.isEmpty) {
      FunctionUtils.showSnackBar(
          context, "Please kindly fill your next of kin whatsapp numbers");
      return;
    }
    var token = SessionManager.instance.token;
    if (token == null) {
      FunctionUtils.showSnackBar(context, 'Operation failed');
      return;
    }

    var client = AppRepository.instance.getRetrofitClient;
    var loadingDialog = FunctionUtils.prepareLoadingDialog(context);
    loadingDialog.show();
    Logger().i(
        'calling with $name $address $num1 $num2 $businessName $businessAddress $plateNo');
    client
        .updateProfile(token.bearerToken(), name, address, num1, num2,
            businessName, businessAddress, plateNo)
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
          response['data']['user'] != null) {
        var user2 = User2.fromJson(response['data']['user']);
        Logger().i("before: ${SessionManager.instance.user!.toJson()}");
        SessionManager.instance.updateUser(user2);
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString(
            loggedInUserResponse, jsonEncode(SessionManager.instance.user));
        Logger().i("after: ${user2.toJson()}");
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
          Logger().e("Got error : ${obj}");
          break;
      }
    });
  }
}
