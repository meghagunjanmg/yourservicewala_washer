import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/notification.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({ Key? key }) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> notifications = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/notifications.json');
    final data = await json.decode(response);

    setState(() {
      notifications = data['notifications']
        .map((data) => NotificationModel.fromJson(data)).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return
            Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),
                child: notificationItem(notifications[index]),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {
                  setState(() {
                    notifications.removeAt(index);
                  });
                }),
                // All actions are defined in the children parameter.
                children: const [
                  SlidableAction(
                    onPressed: null,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              )
            );
        }
      )
    );

  }
  void doNothing(BuildContext context, int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  notificationItem(NotificationModel notification) {
    return
Card(

    elevation: 10,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child:
      Container(
        padding: EdgeInsets.all(18),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 10,),
                Flexible(
                  child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: notification.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      TextSpan(text: notification.content, style: TextStyle(color: Colors.black)),
                      TextSpan(text: notification.timeAgo, style: TextStyle(color: Colors.grey.shade500),)
                    ]
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    )
);

  }
}
