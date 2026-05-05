import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/history_entry_model.dart';

class HistoryDetailPage extends StatelessWidget {
  final HistoryEntry entry;

  const HistoryDetailPage({super.key, required this.entry});

  String _formatDate(DateTime dt) {
    const months = [
      'Januari','Februari','Maret','April','Mei','Juni',
      'Juli','Agustus','September','Oktober','November','Desember'
    ];
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}, $h:$m WIB';
  }

  @override
  Widget build(BuildContext context) {
    final file = File(entry.imagePath);
    final imageExists = file.existsSync();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6FBF7),
        body: Column(
          children: [
            // ── Header ────────────────────────────────────
            _buildHeader(context),

            // ── Konten ────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Gambar
                    _buildImage(imageExists, file),

                    // Informasi hasil
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                      child: Column(
                        children: [
                          _buildResultCard(),
                          const SizedBox(height: 12),
                          _buildDateCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF246A40), Color(0xFF41B06E)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x3018230F),
            blurRadius: 8,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Riwayat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'Hasil deteksi tersimpan',
                    style: TextStyle(
                      color: Color(0xFFFFE432),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(bool imageExists, File file) {
    return Container(
      width: double.infinity,
      height: 350,
      color: const Color(0xFF18230F),
      child: imageExists
          ? Image.file(file, fit: BoxFit.cover)
          : const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Color(0xFF87D05F),
                size: 64,
              ),
            ),
    );
  }

  Widget _buildResultCard() {
    final bool detected = entry.weedName != 'Tidak Dikenali';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF41B06E).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: detected
                  ? const Color(0xFFE8F9EE)
                  : const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              detected
                  ? Icons.eco_rounded
                  : Icons.help_outline_rounded,
              color: detected
                  ? const Color(0xFF41B06E)
                  : const Color(0xFFFFB300),
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detected ? 'Gulma Terdeteksi' : 'Tidak Terdeteksi',
                  style: TextStyle(
                    fontSize: 11,
                    color: detected
                        ? const Color(0xFF41B06E)
                        : const Color(0xFFFFB300),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.weedName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18230F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF41B06E).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F9EE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              color: Color(0xFF41B06E),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Waktu Deteksi',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8FB88A),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formatDate(entry.detectedAt),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF18230F),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}