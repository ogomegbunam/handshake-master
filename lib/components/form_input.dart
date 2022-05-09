import 'package:flutter/material.dart';
import 'package:handshake/constants.dart';

class FormInput extends StatelessWidget {
  String label;
  String hint;
  TextEditingController controller;
  bool enabled;

  FormInput(this.label, this.controller, {this.enabled = true, this.hint = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${label}",
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: kblue),
              color: inputColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                textCapitalization: TextCapitalization.characters,
                enabled: enabled,
                cursorColor: kblack,
                controller: controller,
                keyboardType: label == "Email"
                    ? TextInputType.emailAddress
                    : label == "Phone Number"
                        ? TextInputType.phone
                        : TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  fillColor: inputColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: hint,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
