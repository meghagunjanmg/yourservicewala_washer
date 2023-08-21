import 'package:flutter/material.dart';

import '../constant/ColorConstants.dart';
import '../models/Order.dart';


class OrderDetailScreen extends StatefulWidget {
  Order order;

  OrderDetailScreen({required this.order});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState(order);
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  Order order;

  _OrderDetailScreenState(this.order);

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
          "Order Detail",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  )),
              child: Column(
                children: <Widget>[
                  listItemContainer("Car Model",order.carModel.toString()),
                  listItemContainer("Car Number", order.carNumber.toString()),
                  listItemContainer("Customer Name",order.userName.toString()),
                  listItemContainer("Package Name",order.packageName.toString()),
                  listItemContainer("Order Date", order.orderDate.toString()),
                  listItemContainer("Service Date", order.serviceDateTime.toString()),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle rejecting order
                  },
                  child: Text('Service Start'),
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstants.darkBlueTheme, // Change the background color here
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle completing order
                  },
                  child: Text('Service Done'),
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstants.darkBlueTheme, // Change the background color here
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Widget listItemContainer(String title, String value) => Container(
  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  padding: EdgeInsets.symmetric(vertical: 10.0),
  width: double.infinity,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 5),
      Text(
        title,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(196, 196, 196, 1)),
      ),
      SizedBox(height: 6),
      Text(
        value,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 5),
    ],
  ),
  decoration: BoxDecoration(
      border: new Border(
          bottom: new BorderSide(width: 1.0, color: Color(0xffC4C4C4)))),
);