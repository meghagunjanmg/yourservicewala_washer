import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'ColorConstants.dart';

class CustomDialog extends StatelessWidget {
  final String icon;
  final String text;

  CustomDialog({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstants.darkBlueTheme,
      contentPadding: EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        SvgPicture.asset(
        icon, // Replace with your SVG asset path
        color: Colors.white,
        fit: BoxFit.fitHeight,
      ),
          SizedBox(height: 20),
          Text(text, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18),),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Back',style: TextStyle(color: ColorConstants.darkBlueTheme,fontSize: 18)),
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Change the background color here
            ),
          ),
        ],
      ),
    );
  }
}