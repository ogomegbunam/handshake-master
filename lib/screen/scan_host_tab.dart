import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_qr_scan/flutter_qr_scan.dart';
import 'package:handshake/constants.dart';
import 'package:handshake/data/models/responses/user_model.dart';
import 'package:handshake/data/models/responses/user_model2.dart';
import 'package:handshake/data/repository/app_repository.dart';
import 'package:handshake/data/repository/session.dart';
import 'package:handshake/utils/function_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanHostTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanHostTabState();
}

class _ScanHostTabState extends State<ScanHostTab> {
  User? user;
  var imageBytes;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isFlashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    user = SessionManager.instance.user;
    //Logger().i('${user?.qr_code}');

    if (user != null && user!.qr_code != null) {
      imageBytes = const Base64Decoder().convert(user!.qr_code!.split(',')[1]);
    }
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return Container(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: kblue,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () async {
                    var image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image == null) {
                      Logger().i('null image');
                      return;
                    }
                    final code =
                        await FlutterQrReader.imgScan(File(image.path));
                    _getProfile(context, code);
                    Logger().i(code);
                  },
                  icon: const Icon(
                    Icons.photo_library_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller?.toggleFlash().then((value) {
                      setState(() {
                        isFlashOn = !isFlashOn;
                      });
                    });
                  },
                  icon: Icon(
                    isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 20,
            right: 20,
            top: 50,
            child: Text(
              'Align the QR code within the frame to scan',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      var code = scanData.code;
      _getProfile(context, code);
    });
  }

  void _getProfile(BuildContext context, String? code) {
    var token = SessionManager.instance.token;
    if (code != null && token != null) {
      controller?.pauseCamera();
      var dialog = FunctionUtils.prepareLoadingDialog(context);
      dialog.show();
      var client = AppRepository.instance.getRetrofitClient;
      Logger().i('code $code');
      client.verifyQrCode(token.bearerToken(), code).then((value) {
        dialog.hide();
        // Logger().i('msg $value');
        var response = jsonDecode(value);
        if (response != null && response['message'] != null) {
          FunctionUtils.showSnackBar(context, "${response['message']}");
        }
        if (response != null && response['statusCode'] != 200) {
          return;
        }
        if (response['data'] != null) {
          Logger().i(response['data']);
          var user = User2.fromJson(response['data']);
          Navigator.pushReplacementNamed(context, '/hand-shake', arguments: user);
        }
        Logger().i(value);
      }).catchError((Object obj) {
        // non-200 error goes here.
        dialog.hide();
        controller?.resumeCamera();
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
