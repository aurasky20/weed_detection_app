import 'package:flutter/material.dart';
import 'package:weedcheck/features/result/widgets/card_widget.dart';
import 'package:weedcheck/features/result/widgets/result_action_btn.dart';
import 'package:weedcheck/features/result/widgets/header_widget.dart';
import 'package:weedcheck/features/result/widgets/imageResult_widget.dart';
import 'package:weedcheck/features/result/widgets/save_history_widget.dart';

class ResultPage extends StatelessWidget {
  final String result;
  final String imagePath;

  const ResultPage({super.key, required this.result, required this.imagePath});

  bool get _detected =>
      result.isNotEmpty &&
      !result.toLowerCase().contains("tidak") &&
      !result.toLowerCase().contains("unknown") &&
      !result.toLowerCase().contains("not") &&
      !result.toLowerCase().contains("too dark");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF7),
      body: Column(
        children: [
          /// Fixed header
          const ResultHeader(),

          /// Scrollable content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Captured image
                  ResultImage(imagePath: imagePath),

                  /// Body
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        /// Detection result card
                        ResultCard(result: result, detected: _detected),

                        const SizedBox(height: 12),

                        //Save to history button
                        SaveHistoryButton(result: result, imagePath: imagePath),

                        const SizedBox(height: 20),

                        /// Scan Ulang + Kembali ke Beranda
                        const ResultActionButtons(),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
