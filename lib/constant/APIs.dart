import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Screens/HomeScreen.dart';
import '../models/ResponseModel.dart';

class API {
     static String HeaderUserId = "11";
     static String HeaderPassword = "21";

     static void LoginAPI(BuildContext context,String PhoneNumber,String Password)  async {

       var bod = jsonEncode({
         "USER_ID":PhoneNumber,
         "Passwd":Password
       });

       Map<String,String> hed = new Map();
       hed.putIfAbsent("UserId", () => HeaderUserId);
       hed.putIfAbsent("Passw", () => HeaderPassword);
       hed.putIfAbsent("Content-Type", () => "application/json");


       var url = Uri.https("yourservicewala.in", "/testingapi/WasherLogin");
       var response = await http.post( url, body: bod, headers: hed );

       print('Response status: ${response.statusCode}');
       print('Response body: ${response.body}');


       String jsonObjectStr = response.body.toString();

       Map<String, dynamic> jsonObject = json.decode(jsonObjectStr);
       ResponseModel responseModel = ResponseModel.fromJson(jsonObject);
       print('Response title: '+responseModel.status.toString());
       print('Response title: '+responseModel.description.toString());

       if(responseModel.status==1){
         final SharedPreferences prefs = await SharedPreferences.getInstance();
         await prefs.setBool('is_login', true);
         await prefs.setString('userMobileNo', PhoneNumber);

      //   API.GetProfileAPI(context, PhoneNumber.toString());

         Navigator.pushReplacement(
             context,
             PageRouteBuilder(
                 pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                 transitionsBuilder: (context, animation, secondaryAnimation, child) {
                   var begin = 0.0;
                   var end = 1.0;
                   var curve = Curves.easeInOut;
                   var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                   return ScaleTransition(
                     scale: animation.drive(tween),
                     child: child,
                   );
                 }));
       }
       else{
         Fluttertoast.showToast(
             msg: responseModel.description.toString(),
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.blue,
             textColor: Colors.white,
             fontSize: 16.0
         );
       }
     }


}