import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handshake/components/reusable_button.dart';
import 'package:handshake/data/models/responses/user_model.dart';
import 'package:handshake/data/repository/session.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class MyCodeTab extends StatelessWidget {
  User? user;
  var imageBytes;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    user = SessionManager.instance.user;
    //Logger().i('${user?.qr_code}');

    if (user != null && user!.qr_code != null) {
      imageBytes = const Base64Decoder().convert(user!.qr_code!.split(',')[1]);
    }
    return Container(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 50,
            right: 50,
            top: 100,
            bottom: 200,
            child: Card(
              color: const Color.fromRGBO(31, 36, 41, 1),
              child: Container(),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 80,
            child: OtherButton(
                onPressedFunction: () {
                  _saveToDisk(context);
                },
                label: 'Download My Code'),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: OtherButton(
                onPressedFunction: () {
                  var url = 'https://tinyurl.com/AntiKidnapdotcom';
                  launch(url);
                },
                label: 'Order AntiKidnap Digital Kit'),
          ),
          Positioned(
            top: 50,
            child: CircleAvatar(
              radius: 46,
              backgroundColor: kblue,
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
                        "assets/Camera.png",
                        height: 70,
                        width: 70,
                      ),
              ),
            ),
          ),
          Positioned(
            top: 160,
            child: Text(
              '${user?.full_name}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            top: 150,
            child: Image.memory(imageBytes),
          ),
        ],
      ),
    );
  }

  Future<void> _saveToDisk(BuildContext context) async {
    var status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(imageBytes),
        quality: 100,
        name: "my-code",
      );
      Logger().i(result);
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission is not granted'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
