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
  // Gunakan BoxDecoration untuk mengatur warna latar belakang dan gradien
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter, // Mirip dengan 90deg di CSS
      end: Alignment.bottomRight,
      colors: [
        Color(0x9041B06E), // Hijau asal
        Color(0x90CAEF51), // Hijau Limau
      ],
      // Mengatur distribusi warna jika diperlukan
      stops: [0.0, 1.0], 
    ),
  ),
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
              fontWeight: FontWeight.bold, // Agar teks lebih terbaca di atas gradien
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