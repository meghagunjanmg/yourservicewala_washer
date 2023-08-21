import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../constant/ColorConstants.dart';



class CreateTicketWidget extends StatefulWidget {
  @override
  _CreateTicketWidgetState createState() => _CreateTicketWidgetState();
}

class _CreateTicketWidgetState extends State<CreateTicketWidget> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  File? _attachedImage;

  void _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() {
      _attachedImage = File(pickedImage.path);
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
          "Create Ticket",
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
            // Enter Subject
            _buildTextField('Enter Subject', _subjectController),

            // Row: Select Issue and Select Priority
            Row(
              children: [
                Expanded(
                  child: _buildDropdown('Select Issue', ['Issue 1', 'Issue 2', 'Issue 3']),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildDropdown('Select Priority', ['Low', 'Medium', 'High']),
                ),
              ],
            ),

            // Enter Message
            _buildTextField('Enter Message', _messageController),

            SizedBox(height: 16),

            // Row with Text, Choose Photo Button, and ImageView
            Row(
              children: [
                Text('Attach Car Photo (800X600)'),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstants.darkBlueTheme, // Change the background color here
                  ),
                  onPressed: _pickImage,
                  child: Text('Choose Photo'),
                ),

              ],
            ),
            SizedBox(width: 8),
            _attachedImage != null
                ? Image.file(_attachedImage!, width: 80, height: 60, fit: BoxFit.fitHeight)
                : Container(),
            SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorConstants.darkBlueTheme, // Change the background color here
              ),
              onPressed: _onSubmit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintStyle: TextStyle(color: Colors.blue),
          filled: true,
          fillColor: Color(0xFFE6F0FF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFE6F0FF),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          hint: Text(label, style: TextStyle(color: Colors.blue)),
          value: null,
          onChanged: (value) {
            // Handle dropdown selection here
          },
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _onSubmit() {
    // Handle the ticket submission here
    // You can access the entered values using the controller variables and the attached image using _attachedImage.
    String subject = _subjectController.text;
    String message = _messageController.text;
    print('Subject: $subject');
    print('Message: $message');
    print('Attached Image: $_attachedImage');
  }
}
