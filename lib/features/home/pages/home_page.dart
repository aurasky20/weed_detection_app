import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/home_carousel.dart';
import '../widgets/weed_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          /// 🔝 HEADER (FIXED)
          const HomeHeader(),

          /// 📜 CONTENT (SCROLLABLE)
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Hero Carousel
                  const HomeCarousel(),

                  const SizedBox(height: 28),

                  /// Weed Sections
                  const WeedSection(title: "Gulma Daun Lebar"),
                  const WeedSection(title: "Gulma Daun Sempit"),
                  const WeedSection(title: "Gulma Teki-tekian"),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}