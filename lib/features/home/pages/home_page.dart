import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/home_carousel.dart';
import '../widgets/weed_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 🔝 HEADER (FIXED)
          HomeHeader(),
          /// 📜 CONTENT (SCROLL)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeCarousel(),

                  SizedBox(height: 20),

                  WeedSection(
                    title: "Gulma Daun Lebar",
                  ),

                  WeedSection(
                    title: "Gulma Daun Sempit",
                  ),

                  WeedSection(
                    title: "Gulma Teki-teki",
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}