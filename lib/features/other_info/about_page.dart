import 'package:flutter/material.dart';
import 'package:weedcheck/features/other_info/infosub_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoSubpageScaffold(
      title: "Tentang Aplikasi",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Logo hero
          Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF246A40), Color(0xFF41B06E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF41B06E).withOpacity(0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.eco_rounded,
                      color: Color(0xFFFFDD34), size: 40),
                ),
                const SizedBox(height: 14),
                const Text(
                  "WeedCheck",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF18230F),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Aplikasi Deteksi Gulma berbasis AI",
                  style: TextStyle(
                    fontSize: 13,
                    color: const Color(0xFF18230F).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          _InfoCard(
            icon: Icons.flag_rounded,
            title: "Tujuan Aplikasi",
            content:
                "WeedCheck hadir untuk membantu petani dan peneliti mengidentifikasi jenis gulma secara cepat dan akurat menggunakan teknologi kecerdasan buatan (AI) berbasis model YOLO.",
          ),

          const SizedBox(height: 12),

          _InfoCard(
            icon: Icons.psychology_rounded,
            title: "Teknologi",
            content:
                "Aplikasi ini menggunakan model deteksi objek YOLOv8 yang dilatih pada dataset gulma lokal Indonesia, dijalankan secara offline di perangkat menggunakan TensorFlow Lite.",
          ),

          const SizedBox(height: 12),

          _InfoCard(
            icon: Icons.grass_rounded,
            title: "Kategori Gulma",
            content:
                "WeedCheck mampu mengenali tiga kategori utama gulma:\n• Gulma Daun Lebar\n• Gulma Daun Sempit\n• Gulma Teki-teki",
          ),

          const SizedBox(height: 12),

          _InfoCard(
            icon: Icons.people_rounded,
            title: "Tim Pengembang",
            content:
                "Dikembangkan sebagai proyek penelitian untuk mendukung pertanian presisi di Indonesia.",
          ),

          const SizedBox(height: 24),

          /// Version info row
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FAF4),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: const Color(0xFF87D05F).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    color: const Color(0xFF41B06E).withOpacity(0.7), size: 16),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "Versi 1.0.0 · Build 2025",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF41B06E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: const Color(0xFF41B06E).withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF41B06E).withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F0),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: const Color(0xFF41B06E), size: 16),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF18230F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFF18230F).withOpacity(0.65),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}