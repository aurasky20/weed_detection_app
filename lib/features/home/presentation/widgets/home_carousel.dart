import 'package:flutter/material.dart';

class HomeCarousel extends StatelessWidget {
  final List<String> messages = [
    "Selamat datang di WeedCheck",
    "Deteksi gulma dengan mudah",
    "Solusi untuk pertanian modern"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.green[300],
      child: PageView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                messages[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}