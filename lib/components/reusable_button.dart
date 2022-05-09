import 'package:flutter/material.dart';
import 'package:handshake/constants.dart';

class OtherButton extends StatelessWidget {
  VoidCallback onPressedFunction;
  String label;

  OtherButton({required, required this.onPressedFunction, required this.label});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 13.5),
      minWidth: double.infinity,
      height: 50,
      onPressed: onPressedFunction,
      color: kblue,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
