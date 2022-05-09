import 'package:flutter/material.dart';
import 'package:handshake/constants.dart';


class Checker extends StatefulWidget {
  Checker({Key? key}) : super(key: key);

  @override
  _CheckerState createState() => _CheckerState();
}

class _CheckerState extends State<Checker> {
  bool _checkbox = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      splashRadius: 30,
      activeColor: kblue,
      shape: CircleBorder(),
      value: _checkbox,
      tristate: true,
      onChanged: (value) {
        setState(() {
          _checkbox = !_checkbox;
        });
      },
    );
  }
}
