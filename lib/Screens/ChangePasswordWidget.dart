import 'package:flutter/material.dart';

import '../constant/ColorConstants.dart';
import '../constant/CustomWidget.dart';

class ChangePasswordWidget extends StatefulWidget {
  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  CustomWidget customWidget = CustomWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            customWidget.buildTextField(context,'Old Password', _oldPasswordController, Icons.lock),
            customWidget.buildTextField(context,'New Password', _newPasswordController, Icons.lock_outline),
            customWidget.buildTextField(context,'Confirm Password', _confirmPasswordController, Icons.lock_open),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorConstants.darkBlueTheme, // Change the background color here
              ),
              onPressed: _onChangePassword,
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }


  void _onChangePassword() {
    // Handle the password change here
    // You can access the entered values using the controller variables.
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Perform password validation and change password logic here
    if (newPassword != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('New password and confirm password do not match.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Password change logic here
      // You can show success message or navigate to another screen after successful password change.
      print('Password changed successfully.');
    }
  }
}
