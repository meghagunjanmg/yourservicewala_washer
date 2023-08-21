import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/APIs.dart';
import '../constant/ColorConstants.dart';
import '../constant/CustomWidget.dart';


class EditProfileWidget extends StatefulWidget {
  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  CustomWidget customWidget = CustomWidget();


  TextEditingController _nameController = TextEditingController();
  TextEditingController _address1Controller = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _adhaarnumberController = TextEditingController();


  @override
  void initState() {
    super.initState();

      asyncMethod(); ///initiate your method here
  }

  Future<void> asyncMethod() async{

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  }

  @override
  Widget build(BuildContext context) {
   /// asyncMethod();

    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon:Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            customWidget.buildTextField(context,'Your Name', _nameController, Icons.person),
            customWidget.buildTextField(context,'Address_1', _address1Controller, Icons.home),
            customWidget.buildTextField(context,'Mobile', _mobileController, Icons.phone, isRequired: true),
            customWidget.buildTextField(context,'Adhaar Card Number', _adhaarnumberController, Icons.credit_card_sharp),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorConstants.darkBlueTheme, // Change the background color here
              ),
              onPressed: _onSubmit,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }



  void _onSubmit() {
    // Handle the form submission here
    // You can access the entered values using the controller variables.
    print('Your Name: ${_nameController.text}');
    print('Address_1: ${_address1Controller.text}');
    print('Mobile: ${_mobileController.text}');
    print('Adhaar Card Number: ${_adhaarnumberController.text}');



  }
}
