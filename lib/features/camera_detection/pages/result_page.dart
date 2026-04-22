import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../controllers/tflite_service.dart';

import 'package:image/image.dart' as img; // Pastikan import ini ada di paling atas

class ResultPage extends StatefulWidget {
  final String imagePath;

  const ResultPage({required this.imagePath});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String result = "Memproses...";
  late TFLiteService tflite;

  @override
  void initState() {
    super.initState();

    tflite = TFLiteService();

    loadModelAndDetect();
  }

  void loadModelAndDetect() async {
    await tflite.loadModel();

    runDetection();
  }

  void runDetection() async {
  try {
    File imageFile = File(widget.imagePath);
    print("Memulai deteksi untuk: ${widget.imagePath}");

    var input = preprocessImage(imageFile);

    // Jalankan model
    final List<double> output = tflite.runModel(input);
    print("Output Model Raw: $output"); // Cek apakah nilainya keluar atau nol semua

    // AMBIL INDEX TERBESAR
    double maxScore = output.reduce((a, b) => a > b ? a : b);
    int index = output.indexOf(maxScore);
    
    print("Index Terdeteksi: $index dengan skor: $maxScore");

    if (mounted) {
      setState(() {
        result = getLabel(index);
      });
    }

  } catch (e) {
    print("Error Detail: $e");
    setState(() {
      result = "Terjadi kesalahan saat deteksi";
    });
  }
}

List preprocessImage(File imageFile) {
  // 1. Ambil bytes dari file gambar asli (dari galeri atau kamera)
  final bytes = imageFile.readAsBytesSync();
  
  // 2. Decode gambar menjadi objek image yang bisa diolah
  final originalImage = img.decodeImage(bytes);
  if (originalImage == null) return [];

  // 3. Resize gambar ke 640x640 (Sesuai kebutuhan YOLOv8)
  final resizedImage = img.copyResize(originalImage, width: 640, height: 640);

  // 4. Siapkan List untuk menampung data Float32 (1 * 640 * 640 * 3)
  // Kita gunakan Float32List untuk performa lebih cepat
  var input = List<double>.filled(1 * 640 * 640 * 3, 0.0);
  
  int index = 0;
  for (int y = 0; y < 640; y++) {
    for (int x = 0; x < 640; x++) {
      final pixel = resizedImage.getPixel(x, y);
      
      // Normalisasi nilai pixel dari 0-255 menjadi 0.0-1.0
      // YOLOv8 biasanya butuh normalisasi ini
      input[index++] = pixel.r / 255.0; // Red
      input[index++] = pixel.g / 255.0; // Green
      input[index++] = pixel.b / 255.0; // Blue
    }
  }

  // 5. Kembalikan data dengan bentuk [1, 640, 640, 3]
  return input.reshape([1, 640, 640, 3]);
}

  String getLabel(int index) {
  switch (index) {
    case 0:
      return "Gulma Daun Lebar";
    case 1:
      return "Gulma Daun Sempit";
    case 2:
      return "Gulma Teki-teki";
    default:
      return "Bukan Gulma";
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hasil Deteksi")),
      // Menggunakan SingleChildScrollView agar halaman bisa di-scroll
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Agar konten memenuhi lebar layar
          children: [
            // Membungkus gambar agar tidak terlalu besar dan rapi
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6, // Maksimal 60% tinggi layar
              ),
              width: double.infinity,
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.contain, // Gambar tetap utuh tanpa terpotong
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Hasil Analisis:",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26, 
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // Memberikan ruang di bawah agar tidak terlalu mepet saat scroll
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}