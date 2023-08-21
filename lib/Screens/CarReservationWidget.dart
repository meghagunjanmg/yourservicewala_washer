import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/marked_date.dart';
import 'package:flutter_calendar_carousel/classes/multiple_marked_dates.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../constant/ColorConstants.dart';

class CarReservationWidget extends StatefulWidget {
  @override
  _CarReservationWidgetState createState() => _CarReservationWidgetState();
}

class _CarReservationWidgetState extends State<CarReservationWidget> {
  List<DateTime> _selectedDates = [];
  String _selectedCar = 'Car A'; // Default car selection

  String selectedValue = "";
  void _onDaySelected(DateTime selectedDate, bool value) {
    setState(() {
      if (value) {
        _selectedDates.add(selectedDate);
      } else {
        _selectedDates.remove(selectedDate);
      }
    });
  }

  void _onCarSelected(String car) {
    setState(() {
      _selectedCar = car;
    });
  }

  void _onSubmit() {
    // Handle the form submission here
    print('Selected Dates: $_selectedDates');
    print('Selected Car: $_selectedCar');
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
          "Calender",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Custom Calendar
              CustomCalendar(
                onDaySelected: _onDaySelected,
                selectedDates: _selectedDates,
              ),

              SizedBox(height:20),

              // Selected Dates
              Text(
                'Selected Dates:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Wrap(
                children: _selectedDates.map((date) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Chip(label: Text(DateFormat('MM/dd/yyyy').format(date))),
                  );
                }).toList(),
              ),

              SizedBox(height: 16),

              // Submit Button
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
      ),
    );
  }
}

class CustomCalendar extends StatelessWidget {
  final Function(DateTime, bool) onDaySelected;
  final List<DateTime> selectedDates;
  CustomCalendar({required this.onDaySelected, required this.selectedDates});

  @override
  Widget build(BuildContext context) {
    return CalendarCarousel(
      onDayPressed: (DateTime date, List<Event> events) {
        final isSelected = selectedDates.contains(date);
        onDaySelected(date, !isSelected);
      },
      headerTextStyle: TextStyle(color: ColorConstants.darkBlueTheme),
      leftButtonIcon: Icon(Icons.navigate_before,color: ColorConstants.darkBlueTheme,),
      rightButtonIcon: Icon(Icons.navigate_next,color: ColorConstants.darkBlueTheme,),
      weekdayTextStyle: TextStyle(color: ColorConstants.darkBlueTheme),
      thisMonthDayBorderColor: Colors.grey,
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(color: ColorConstants.darkBlueTheme),
      weekFormat: false,
      height:400.0,
      selectedDayBorderColor: Colors.transparent,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
    );
  }

  // Generates the map for marking selected dates in the calendar
  static Map<DateTime, List<Event>> _generateDateMap(List<DateTime> selectedDates) {
    final Map<DateTime, List<Event>> dateMap = {};

    for (var date in selectedDates) {
      dateMap[date] = [
        Event(
          date: date,
          icon: Icon(Icons.check, color: Colors.blue),
        ),
      ];
    }

    return dateMap;
  }
}

// Event class for marking dates with icons
class Event {
  final DateTime date;
  final Icon icon;

  Event({required this.date, required this.icon});
}
