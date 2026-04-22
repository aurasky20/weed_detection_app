import 'package:flutter/material.dart';

class WeedCard extends StatelessWidget {
  final String name;
  final String image;

  const WeedCard({
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          /// 📷 IMAGE (NETWORK)
          Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 5),

          /// 📝 NAME
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}