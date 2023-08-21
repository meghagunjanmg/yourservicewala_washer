import 'package:flutter/material.dart';

class RewardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 16, // Spacing between columns
        mainAxisSpacing: 16, // Spacing between rows
        padding: EdgeInsets.all(16),
        children: List.generate(rewards.length, (index) {
          return RewardCard(
            icon: rewards[index].icon,
            points: rewards[index].points,
            name: rewards[index].name,
          );
        }),
      ),
    );
  }
}

class RewardCard extends StatefulWidget {
  final IconData icon;
  final int points;
  final String name;

  RewardCard({required this.icon, required this.points, required this.name});

  @override
  _RewardCardState createState() => _RewardCardState();
}

class _RewardCardState extends State<RewardCard> with SingleTickerProviderStateMixin {
  bool _isZoomed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isZoomed = !_isZoomed;
        });
      },
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 48,
                color: Colors.blue,
              ),
              SizedBox(height: 8),
              Text(
                '${widget.points} Points',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
    );
  }
}

// Sample data for rewards
class RewardData {
  final IconData icon;
  final int points;
  final String name;

  RewardData({required this.icon, required this.points, required this.name});
}

List<RewardData> rewards = [
  RewardData(icon: Icons.card_giftcard, points: 100, name: 'Gift Card'),
  RewardData(icon: Icons.star, points: 200, name: 'Star Badge'),
  RewardData(icon: Icons.free_breakfast, points: 150, name: 'Free Breakfast'),
  RewardData(icon: Icons.shopping_cart, points: 250, name: 'Shopping Voucher'),
];
