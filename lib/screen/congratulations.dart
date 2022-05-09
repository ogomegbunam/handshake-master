import 'package:flutter/material.dart';
import 'package:handshake/components/app_style.dart';
import 'package:handshake/components/reusable_button.dart';

class CustomDailog extends StatefulWidget {
  const CustomDailog({Key? key}) : super(key: key);

  @override
  _CustomDailogState createState() => _CustomDailogState();
}

class _CustomDailogState extends State<CustomDailog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified, color: Colors.green, size: 100),
              const SizedBox(height: 25),
              const Text("Congratulations!", style: AppStyle.boldText),
              const SizedBox(height: 10),
              const Text("You have successfully confirm this handshake",
                  style: AppStyle.faintText),
              const SizedBox(height: 30),
              OtherButton(
                  onPressedFunction: () {
                    Navigator.popUntil(context, ModalRoute.withName('/home'));
                  },
                  label: 'Continue')
            ],
          ),
        ),
      ),
    );
  }
}
