import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handshake/constants.dart';
import 'package:handshake/utils/callbacks.dart';

class Options extends StatefulWidget {
  final OnValueChanged onValueChanged;

  const Options({Key? key, required this.onValueChanged}) : super(key: key);


  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  String _selectedValue = 'No';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedValue = 'Yes';
              widget.onValueChanged(_selectedValue);
            });
          },
          child: Container(
            width: 150,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    width: 2,
                    color: (_selectedValue == 'Yes' ? kblue : Colors.grey))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    _selectedValue == 'Yes'
                        ? Icons.radio_button_checked_outlined
                        : Icons.radio_button_off,
                    color: _selectedValue == 'Yes' ? kblue : Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'YES',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: _selectedValue == 'Yes' ? kblue : Colors.grey),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedValue = 'No';
              widget.onValueChanged(_selectedValue);
            });
          },
          child: Container(
            width: 150,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    width: 2,
                    color: (_selectedValue == 'No' ? kblue : Colors.grey))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Icon(
                  _selectedValue == 'No'
                      ? Icons.radio_button_checked_outlined
                      : Icons.radio_button_off,
                  color: _selectedValue == 'No' ? kblue : Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'NO',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: _selectedValue == 'No' ? kblue : Colors.grey),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
