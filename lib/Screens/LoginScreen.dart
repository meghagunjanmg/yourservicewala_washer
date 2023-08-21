import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yourservicewala_washer/Screens/NotificationScreen.dart';


import '../constant/APIs.dart';
import '../constant/ColorConstants.dart';
import 'HomeScreen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            SizedBox(height: 24),
            Text(
              'User Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Sign in to continue',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 24),
            Container(
            child: TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                counterText: "",
                prefixIcon:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/phone.svg',
                  ),
                ),
                hintStyle: TextStyle(color: Colors.blue),
                filled: true,
                fillColor: ColorConstants.textFieldBgTheme,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),),
          ),
            SizedBox(height: 12),
            Container(
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/password.svg',
                    ),
                  ),
                  hintStyle: TextStyle(color: Colors.blue),
                  filled: true,
                  fillColor: ColorConstants.textFieldBgTheme,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),),
            ),            SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                ),
                Text('Remember me'),
                Spacer(),
              ],
            ),
            SizedBox(height: 12,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorConstants.darkBlueTheme, // Change the background color here
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  // Add your login logic here
                   API.LoginAPI(context,phoneNumberController.text, passwordController.text);
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}