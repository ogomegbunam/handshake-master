import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FlutterQrReader {
  static const MethodChannel _channel =
      const MethodChannel('me.hetian.flutter_qr_reader');

  static Future<String?> imgScan(File file) async {
    if (file.existsSync() == false) {
      return null;
    }
    try {
      final rest =
          await _channel.invokeMethod("imgQrCode", {"file": file.path});
      return rest;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
typedef ReadChangeBack = void Function(String?, List<Offset>, String?);
