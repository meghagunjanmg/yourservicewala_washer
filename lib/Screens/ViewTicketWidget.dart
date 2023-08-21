import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/ColorConstants.dart';


class ViewTicketWidget extends StatefulWidget {
  @override
  _ViewTicketWidgetState createState() => _ViewTicketWidgetState();
}

class _ViewTicketWidgetState extends State<ViewTicketWidget> {
  List<String> columns = [
    'Ticket ID',
    'Subject',
    'Issue',
    'Priority',
    'Status',
    'Created Date',
    'Assigned To',
    'Description',
    'Attachments',
  ];

  List<List<String>> data = [
    ['1', 'Sample Ticket 1', 'Issue 1', 'High', 'Open', '2023-07-19', 'User 1', 'This is a sample description.', '1 attachment'],
    ['2', 'Sample Ticket 2', 'Issue 2', 'Medium', 'In Progress', '2023-07-20', 'User 2', 'Another sample description.', '2 attachments'],
    // Add more ticket data as needed...
  ];

  List<String> selectedFields = ['0', '1', '2', '3', '4', '5', '6', '7', '8']; // All fields selected by default

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
          "View Ticket",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Segmented buttons
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.darkBlueTheme, // Change the background color here
                      ),
                      onPressed: _onCopy,
                      child: Text('Copy'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.darkBlueTheme, // Change the background color here
                      ),
                      onPressed: _onDownloadExcel,
                      child: Text('Excel'),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),

      Container(
        padding: EdgeInsets.all(8),
        child:Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.darkBlueTheme, // Change the background color here
                      ),
                      onPressed: _onDownloadPDF,
                      child: Text('PDF'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.darkBlueTheme, // Change the background color here
                      ),
                      onPressed: _onPrint,
                      child: Text('Print'),
                    ),
                  ),
                  SizedBox(width: 16),
                ]
            ),),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Custom Visiblity"),
                ),
                Container(
                  child: _buildColumnVisibilityDropdown(),
                ),
              ],
            ),
            // Table view

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Padding(
                padding: EdgeInsets.all(16),
                child: DataTable(
                  columns: columns
                      .asMap()
                      .entries
                      .where((entry) => selectedFields.contains(entry.key.toString()))
                      .map((entry) => DataColumn(label: Text(entry.value)))
                      .toList(),
                  rows: data.map((rowData) => DataRow(
                    cells: rowData.asMap().entries.where((entry) => selectedFields.contains(entry.key.toString()))
                        .map((entry) => DataCell(Text(entry.value))).toList(),
                  )).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onCopy() {
    final StringBuffer buffer = StringBuffer();

    // Add the headers (columns) to the buffer
    buffer.writeln(columns.join('\t'));

    // Add each row of data to the buffer
    for (final rowData in data) {
      final String rowString = rowData.asMap().entries
          .where((entry) => selectedFields.contains(entry.key.toString()))
          .map((entry) => entry.value)
          .join('\t');
      buffer.writeln(rowString);
    }

    // Copy the buffer content to the clipboard
    Clipboard.setData(ClipboardData(text: buffer.toString()));

    // Show a snackbar to indicate that the data is copied
    final snackBar = SnackBar(content: Text('Data copied to clipboard'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  void _onDownloadExcel() {

  }


  void _onDownloadPDF() {
   }



  void _onPrint() async {

  }

  Widget _buildColumnVisibilityDropdown() {
    return DropdownButton<String>(
      value: selectedFields.isNotEmpty ? selectedFields[0] : null,
      onChanged: (value) {
        setState(() {
          selectedFields.contains(value!)
              ? selectedFields.remove(value)
              : selectedFields.add(value);
        });
      },
      items: columns.map((column) {
        return DropdownMenuItem<String>(
          value: columns.indexOf(column).toString(),
          child: Text(column),
        );
      }).toList(),
    );
  }
}
