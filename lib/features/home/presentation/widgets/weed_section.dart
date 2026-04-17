import 'package:flutter/material.dart';
import 'weed_card.dart';

class WeedSection extends StatelessWidget {
  final String title;

  const WeedSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 10),

          /// 🔹 CARD HORIZONTAL
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                WeedCard(
                  name: "Ageratum Conyzoides",
                  image: "assets/images/gulma1.jpg",
                ),
                WeedCard(
                  name: "Amaranthus",
                  image: "assets/images/gulma2.jpg",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}