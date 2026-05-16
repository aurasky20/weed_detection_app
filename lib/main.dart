import 'package:flutter/material.dart';
import 'package:weedcheck/features/splash_screen.dart';
import 'package:weedcheck/presentation/screens/camera_inference_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeedCheck',
      home: CameraInferenceScreen(),
    );
  }
}