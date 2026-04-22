import 'package:flutter/material.dart';
import 'dart:async';
class HomeCarousel extends StatefulWidget {
  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final PageController _controller = PageController();
  final List<String> messages = [
    "Selamat datang di WeedCheck",
    "Aplikasi untuk deteksi Gulma",
    "Solusi di lahan pertanian",
  ];

  @override
  void initState() {
    super.initState();
    // Berpindah halaman otomatis setiap 3 detik
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_controller.hasClients) {
        int nextPage = (_controller.page?.toInt() ?? 0) + 1;
        if (nextPage >= messages.length) nextPage = 0;
        _controller.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Jangan lupa dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Color(0x9041B06E), Color(0x90CAEF51)],
        ),
      ),
      child: PageView.builder(
        controller: _controller, // Pasang controller di sini
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
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF18230F),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}