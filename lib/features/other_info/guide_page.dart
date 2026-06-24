import 'package:flutter/material.dart';
import 'package:weedcheck/features/other_info/infosub_page.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  static const _steps = [
    _GuideStep(
      number: "01",
      icon: Icons.camera_alt_rounded,
      color: Color(0xFF41B06E),
      bg: Color(0xFFEAF7F0),
      title: "Buka Kamera atau Galeri",
      desc:
          "Tekan tombol kamera di tengah navbar. Pilih \"Camera\" untuk foto langsung atau \"Streaming\" untuk deteksi real-time.",
    ),
    _GuideStep(
      number: "02",
      icon: Icons.center_focus_strong_rounded,
      color: Color(0xFF87D05F),
      bg: Color(0xFFF0FAE8),
      title: "Arahkan ke Gulma",
      desc:
          "Pastikan gulma berada di tengah frame kamera. Pencahayaan yang baik akan meningkatkan akurasi deteksi.",
    ),
    _GuideStep(
      number: "03",
      icon: Icons.document_scanner_rounded,
      color: Color(0xFFFFDD34),
      bg: Color(0xFFFFFBE6),
      title: "Ambil Foto / Scan",
      desc:
          "Tekan tombol capture untuk mengambil foto. Aplikasi akan otomatis memproses gambar dan menampilkan hasil.",
    ),
    _GuideStep(
      number: "04",
      icon: Icons.analytics_rounded,
      color: Color(0xFFEF9651),
      bg: Color(0xFFFFF3E8),
      title: "Lihat Hasil Deteksi",
      desc:
          "Hasil berupa nama gulma dan statusnya akan ditampilkan. Simpan ke riwayat jika diperlukan.",
    ),
    _GuideStep(
      number: "05",
      icon: Icons.history_rounded,
      color: Color(0xFF41B06E),
      bg: Color(0xFFEAF7F0),
      title: "Cek Riwayat",
      desc:
          "Buka halaman Riwayat untuk melihat semua hasil deteksi yang pernah disimpan.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return InfoSubpageScaffold(
      title: "Panduan Penggunaan",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FAF4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xFF87D05F).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_rounded,
                    color: Color(0xFFFFDD34), size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Ikuti langkah-langkah berikut untuk hasil deteksi terbaik.",
                    style: TextStyle(
                      fontSize: 13,
                      color: const Color(0xFF18230F).withOpacity(0.65),
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          ..._steps.map((s) => _StepTile(step: s)).toList(),
        ],
      ),
    );
  }
}

class _GuideStep {
  final String number;
  final IconData icon;
  final Color color;
  final Color bg;
  final String title;
  final String desc;
  const _GuideStep({
    required this.number,
    required this.icon,
    required this.color,
    required this.bg,
    required this.title,
    required this.desc,
  });
}

class _StepTile extends StatelessWidget {
  final _GuideStep step;
  const _StepTile({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: step.color.withOpacity(0.15)),
          boxShadow: [
            BoxShadow(
              color: step.color.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: step.bg,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(step.icon, color: step.color, size: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  step.number,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: step.color.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18230F),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    step.desc,
                    style: TextStyle(
                      fontSize: 13,
                      color: const Color(0xFF18230F).withOpacity(0.6),
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}