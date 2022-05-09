import 'package:flutter/material.dart';
import 'package:handshake/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomeButton extends StatelessWidget {

  VoidCallback onpressedfunction;
  String label;
  String asset;

  HomeButton({required , required this.onpressedfunction, required this.label,required this.asset});

@override
Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return MaterialButton(

    padding: EdgeInsets.symmetric(vertical: 13.5),
    minWidth: double.infinity,
    height: 50,
    onPressed: onpressedfunction,
    color: kblue,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left:40.0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            asset,
            color: kwhite,
            height: 20,
            width: 18,
            cacheColorFilter: true,
          ),
          SizedBox(width: 20,),

          Text(label, style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white

          ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
}