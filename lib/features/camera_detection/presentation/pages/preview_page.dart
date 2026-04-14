import 'dart:io';
import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  final String imagePath;

  const PreviewPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hasil Gambar")),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}