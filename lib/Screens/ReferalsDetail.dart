import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constant/ColorConstants.dart';

class ReferalsDetailWidget extends StatefulWidget {
  @override
  _ReferalsDetailState createState() => _ReferalsDetailState();
}

class _ReferalsDetailState extends State<ReferalsDetailWidget> {
  List<String> columns = [
    'S.No',
    'Name',
    'MobileNo',
    'EmailID',
    'userAddress',
    'JoinDate',
    'status',
    'description',
  ];

  List<List<String>> data = [];

  List<String> selectedFields = ['0', '1', '2', '3', '4', '5', '6', '7']; // All fields selected by default


  bool isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getAPiData();
    isloading=false;
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
            "Referal Details",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),

      body:
      (isloading==true)?
      Center(
        child: LoadingAnimationWidget.inkDrop(
          color: ColorConstants.lightBlueTheme,
          size: 100,
        ),
      )
        :
      SingleChildScrollView(
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
                      onPressed: _downloadExcel,
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
                        onPressed: _downloadPDF,
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

            (data.isNotEmpty)?
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
                :
                Text("DATA NOT FOUND")
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

  Future<void> _downloadExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    for (int row = 0; row < data.length; row++) {
      for (int col = 0; col < data[row].length; col++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
          ..value = data[row][col];
      }
    }


    final permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      try {
        final excelBytes = await excel.save();
        final downloadsDir = await DownloadsPathProvider.downloadsDirectory;
        final excelFilePath = '${downloadsDir.path}/table_data.xlsx';
        File(excelFilePath).writeAsBytesSync(excelBytes!, flush: true);

        print(excelFilePath);
        final snackBar = SnackBar(content: Text('xlsx file downloaded'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      } on PlatformException catch (e) {
        print('Error: ${e.message}');
        final snackBar = SnackBar(content: Text('Error: Unable to create directory'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    else {
      final snackBar = SnackBar(content: Text('Permission denied for file storage'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


 Future<void> _downloadPDF() async {
    final pdf = pw.Document();
    final headers = data[0]; // Assume first row contains headers

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Table.fromTextArray(
          headers: headers,
          data: data.sublist(1), // Exclude the headers row
        );
      },
    ));

    final permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      try {
        final pdfBytes = await pdf.save();

        final downloadsDir = await DownloadsPathProvider.downloadsDirectory;
        final pdfDirPath = '${downloadsDir.path}/table_data.pdf';

          File(pdfDirPath).writeAsBytesSync(Uint8List.fromList(pdfBytes));

          print(pdfDirPath);
          final snackBar = SnackBar(content: Text('PDF file downloaded'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

      } on PlatformException catch (e) {
        print('Error: ${e.message}');
        final snackBar = SnackBar(content: Text('Error: Unable to create directory'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(content: Text('Permission denied for file storage'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
class DownloadsPathProvider {
  static Future<Directory> get downloadsDirectory async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else {
      return Directory('/Downloads');
    }
  }
}