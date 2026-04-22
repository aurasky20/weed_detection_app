import 'dart:io';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String result;
  final String imagePath;

  const ResultPage({super.key, required this.result, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Deteksi"),
        backgroundColor: const Color(0xFF41B06E), // Menyesuaikan tema WeedCheck
        foregroundColor: Colors.white,
      ),
      // 1. Tambahkan SingleChildScrollView agar halaman bisa di-scroll
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Menampilkan gambar hasil deteksi
            Image.file(
              File(imagePath),
              fit: BoxFit.cover, // Agar gambar memenuhi lebar layar
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    "Hasil Analisis:",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF18230F),
                    ),
                  ),
                ],
              ),
            ),
            // 2. Beri 40px untuk margin bawah
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}