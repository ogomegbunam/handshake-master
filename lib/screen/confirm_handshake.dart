import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handshake/components/options.dart' as options;
import 'package:handshake/components/profile_display.dart';
import 'package:handshake/components/reusable_button.dart';
import 'package:handshake/constants.dart';
import 'package:handshake/data/models/responses/user_model2.dart';
import 'package:handshake/data/repository/app_repository.dart';
import 'package:handshake/data/repository/session.dart';
import 'package:handshake/utils/function_utils.dart';
import 'package:logger/logger.dart';

class ConfirmHandShake extends StatelessWidget {
  ConfirmHandShake({Key? key}) : super(key: key);
  bool? isConnect;

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as User2;
    return Scaffold(
      backgroundColor: kwhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 46,
                  backgroundColor: kblue,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(85.0),
                    child: user.avatar.isNotEmpty
                        ? CachedNetworkImage(
                            height: 85,
                            width: 85,
                            fit: BoxFit.cover,
                            imageUrl: user.avatar,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Image.asset(
                            "assets/Camera.png",
                            height: 70,
                            width: 70,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ProfileDisplay(
                  label: "Full Name",
                  message: user.full_name,
                ),
                ProfileDisplay(label: "Email Address", message: user.email),
                ProfileDisplay(
                  label: "Phone Number",
                  message: user.phone_number,
                ),
                ProfileDisplay(
                  label: "Next of Kin's Whatsapp Number 1",
                  message: user.nok_phone_number,
                ),
                ProfileDisplay(
                  label: "Next of Kin's Whatsapp Number 2",
                  message: user.nok_alternate_phone_number,
                ),
                ProfileDisplay(
                  label: "Do you have Business?",
                  message: user.business_name != null ? 'Yes' : 'No',
                ),
                ProfileDisplay(
                  label: "Business Name",
                  message: user.business_name ?? '',
                ),
                ProfileDisplay(
                  label: "Business Address",
                  message: user.business_address ?? '',
                ),
                ProfileDisplay(
                  label: "Do you use your vehicle for Transportation",
                  message: user.vehicle_plate_number != null ? 'Yes' : 'No',
                ),
                ProfileDisplay(
                  label: "Vehicle's Plate Number",
                  message: user.vehicle_plate_number ?? '',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Are you sure you want to confirm this handshake?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kblue,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: options.Options(
                    onValueChanged: (String value) {
                      Logger().i('value is $value');
                      isConnect = value == 'Yes';
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OtherButton(
                      onPressedFunction: () {
                        _connect(context, user.id);
                      },
                      label: 'Confirm'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        color: kblue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _connect(BuildContext context, String? uid) {
    if (isConnect == null) {
      FunctionUtils.showSnackBar(context,'Please select Yes or No');
      return;
    }
    if (isConnect == false) {
      Navigator.pop(context);
      return;
    }
    var token = SessionManager.instance.token;
    if (uid != null && token != null) {
      var dialog = FunctionUtils.prepareLoadingDialog(context);
      dialog.show();
      var client = AppRepository.instance.getRetrofitClient;
      Logger().i('code $uid');
      client.confirmContact(token.bearerToken(), uid).then((value) {
        dialog.hide();
        // Logger().i('msg $value');
        var response = jsonDecode(value);
        if (response != null && response['message'] != null) {
          FunctionUtils.showSnackBar(context, "${response['message']}");
        }
        if (response != null && response['statusCode'] != 200) {
          return;
        }
        Navigator.popAndPushNamed(context, "/success");
        Logger().i(value);
      }).catchError((Object obj) {
        // non-200 error goes here.
        dialog.hide();
        FunctionUtils.showSnackBar(context, "Try again");
        switch (obj.runtimeType) {
          case DioError:
            // Here's the sample to get the failed response error code and message
            final res = (obj as DioError).response;
            Logger()
                .e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
            break;
          default:
            Logger().i(obj);
            break;
        }
      });
    }
  }
}
