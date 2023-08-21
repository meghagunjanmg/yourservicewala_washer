import 'package:flutter/material.dart';
import 'package:yourservicewala_washer/constant/ColorConstants.dart';

import '../models/Order.dart';
import 'OrderDetailScreen.dart';


class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> _orders = [
    Order(
      carModel: 'Toyota Camry',
      carNumber: 'XYZ 123',
      userName: 'John Doe',
      orderDate: DateTime.now().subtract(Duration(days: 2)),
      packageName: 'Premium Wash',
      serviceDateTime: DateTime.now().add(Duration(days: 1)),
    ),
    Order(
      carModel: 'Honda Civic',
      carNumber: 'ABC 456',
      userName: 'Jane Smith',
      orderDate: DateTime.now().subtract(Duration(days: 1)),
      packageName: 'Basic Wash',
      serviceDateTime: DateTime.now().add(Duration(days: 2)),
    ),
    // Add more orders here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
         itemCount: _orders.length, // Replace with your actual data count
        itemBuilder: (context, index) {
          return
          GestureDetector(

          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(order: _orders[index])));
          },
          child:  Card(
              // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              // Set the clip behavior of the card
              clipBehavior: Clip.antiAliasWithSaveLayer,
              // Define the child widgets of the card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                  Image.asset(
                    "assets/BG01.jpg",
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Add a container with padding that contains the card's title, text, and buttons
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Display the card's title using a font size of 24 and a dark grey color
                        Text(
                          _orders[index].carModel,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[800],
                          ),
                        ),
                        // Add a space between the title and the text
                        Container(height: 10),
                        // Display the card's text using a font size of 15 and a light grey color
                        Text(
                         "Car number: "+ _orders[index].carNumber+"\nPackage: "+_orders[index].packageName,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                        // Add a row with two buttons spaced apart and aligned to the right side of the card
                        Row(
                          children: <Widget>[
                            // Add a spacer to push the buttons to the right side of the card
                            const Spacer(),
                            // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.transparent,
                              ),
                              child: const Text(
                                "Accept",
                                style: TextStyle(color: Colors.green),
                              ),
                              onPressed: () {},
                            ),
                            // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.transparent,
                              ),
                              child: const Text(
                                "Decline",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Add a small space between the card and the next widget
                  Container(height: 5),
                ],
              ),
            )
          );
        },
      ),
    );
  }
  
}

