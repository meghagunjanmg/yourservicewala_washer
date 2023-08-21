import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ColorConstants.dart';

class CustomWidget {
  Widget buildTextField(BuildContext context, String label,
      TextEditingController controller, IconData icon,
      {bool isRequired = false}) {
    return
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          controller: controller,
          keyboardType: (icon == Icons.date_range) ? null : TextInputType.text,
          readOnly: (icon == Icons.date_range) ? true : false,
          onTap: () {
            (icon == Icons.date_range) ?
            {
              _selectDate(context, controller)
            }
                : {};
          },
          decoration:
          InputDecoration(
            labelText: label,
            hintText: isRequired ? '*Required' : '',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),

              child: Icon(icon, color: ColorConstants.darkBlueTheme),
            ),
            hintStyle: TextStyle(color: ColorConstants.darkBlueTheme),
            filled: true,
            fillColor: ColorConstants.textFieldBgTheme,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                  color: ColorConstants.darkBlueTheme, width: 2),
            ),
          ),
        ),
      );
  }

  void _selectDate(BuildContext context,
      TextEditingController Controller) async {
    DateTime? _selectedDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: ColorConstants.darkBlueTheme, // Change header color
            accentColor: ColorConstants.darkBlueTheme, // Change selected date color
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );


    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      final formattedDate = DateFormat('dd-MM-yyyy').format(
          picked); // Customize the format

      Controller.text = formattedDate.toString(); // Format this as needed
    }
  }

}
