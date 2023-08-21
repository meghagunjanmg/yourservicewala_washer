
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/ColorConstants.dart';
import 'LoginScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  String _message = '';

  void _sendEmail() {
    setState(() {
      _message = 'Email sent to ${_emailController.text}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       leading: new IconButton(
         onPressed: (){
           Navigator.of(context).pop();
         },
         icon:Icon(Icons.arrow_back_ios,color: Colors.black,),
       ),
        title: Text(
          "Forget Password",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 100),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter your email to receive password reset instructions:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 40,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Email or phone number',
                      hintStyle: TextStyle(color: Colors.blue),
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),),
                ),
                SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your login logic here
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                var begin = 0.0;
                                var end = 1.0;
                                var curve = Curves.easeInOut;
                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                return ScaleTransition(
                                  scale: animation.drive(tween),
                                  child: child,
                                );}));
                    },
                    child: Text('Send'),
                    style: ElevatedButton.styleFrom(
                      primary: ColorConstants.darkBlueTheme, // Change the background color here
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _message,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}