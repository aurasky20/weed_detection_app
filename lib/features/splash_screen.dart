import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weedcheck/core/navigation/main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Timer 3 detik untuk pindah ke halaman utama
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Gradien gelap agar logo (hijau terang + kuning) lebih menonjol
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF57BA69), Color(0xFF246A40)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color.fromARGB(255, 253, 255, 186), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 251, 255, 0).withOpacity(0.25), // warna bayangan
                    blurRadius: 10, // tingkat blur
                    spreadRadius: 2, // ukuran bayangan
                    offset: const Offset(0, 4), // posisi (x, y)
                  ),
                ],
              ),
              // padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: const AssetImage('assets/icon/logo.png'),
                  height: 100,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Nama Aplikasi
            Text(
              "WeedCheck",
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Smart Farming, Better Result",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 50),
            // Loading indicator kecil di bawah
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFEDC00)),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
