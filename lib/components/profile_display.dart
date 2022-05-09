import 'package:flutter/material.dart';
import 'package:handshake/constants.dart';

class ProfileDisplay extends StatelessWidget {
  final String? message;
  final VoidCallback? onPressed;
  final Color? color;
  final String? label;

  const ProfileDisplay(
      {this.message, this.onPressed, this.color = kwhite, this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(label!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kblack,
                    )),
              ),
              Card(
                elevation: 1,
                  color: color,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(message!,style: TextStyle( fontWeight: FontWeight.w600,fontSize: 12,
                    color: Colors.grey),),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}