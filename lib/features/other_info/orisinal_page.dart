import 'package:flutter/material.dart';
import 'package:weedcheck/features/other_info/infosub_page.dart';

class LegalDisclaimerPage extends StatelessWidget {
  const LegalDisclaimerPage({super.key});

  // Contoh data paket open source (sesuaikan dengan pubspec.yaml Anda)
  static const List<_Package> _packages = [
    _Package(name: 'flutter', license: 'BSD-3-Clause'),
    _Package(name: 'tflite_flutter', license: 'Apache 2.0'),
  ];

  @override
  Widget build(BuildContext context) {
    return InfoSubpageScaffold(
      title: "Legalitas & Orisinalitas",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF7F0),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF41B06E).withOpacity(0.35),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.gavel_rounded, color: Color(0xFF41B06E), size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Dokumen Legal",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF41B06E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// Container berbentuk surat resmi
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF18230F).withOpacity(0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF18230F).withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "SYARAT PENGGUNAAN & PENAFIAN",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18230F),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "WeedCheck Versi 1.0.0\nCopyright © 2026 Aura Sasi Kirana Dharma Acintya.\nSemua Hak Dilindungi Undang-Undang.",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF18230F).withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFEAF7F0), thickness: 1.5),
                const SizedBox(height: 16),
                Text(
                  "Mohon membaca ketentuan ini dengan saksama sebelum menggunakan aplikasi WeedCheck:",
                  style: TextStyle(
                    fontSize: 13,
                    color: const Color(0xFF18230F).withOpacity(0.8),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                
                /// Poin-poin bernomor
                const _NumberedParagraph(
                  number: "1.",
                  title: "Fungsi Aplikasi",
                  content:
                      "WeedCheck adalah alat bantu berbasis teknologi untuk mengidentifikasi jenis gulma (seperti daun lebar, daun sempit, dan teki-tekian) berdasarkan analisis gambar. Model AI dan anotasi dataset dibangun secara mandiri.",
                ),
                const _NumberedParagraph(
                  number: "2.",
                  title: "Akurasi Hasil",
                  content:
                      "Hasil deteksi yang diberikan oleh aplikasi ini bersifat referensi dan edukatif. Pengembang tidak menjamin akurasi 100% karena hasil pemindaian sangat dipengaruhi oleh kualitas resolusi kamera, pencahayaan, sudut pengambilan, dan kondisi fisik gulma di lapangan.",
                ),
                const _NumberedParagraph(
                  number: "3.",
                  title: "Batasan Tanggung Jawab",
                  content:
                      "Pengembang tidak bertanggung jawab atas segala bentuk kerugian material, kegagalan panen, atau kesalahan penanganan lahan pertanian yang disebabkan oleh keputusan pengguna yang hanya bersandar pada hasil deteksi aplikasi ini. Pengguna diwajibkan untuk tetap melakukan verifikasi manual.",
                ),
                const _NumberedParagraph(
                  number: "4.",
                  title: "Orisinalitas & Hak Cipta",
                  content:
                      "Seluruh kode sumber, dataset yang dikumpulkan, dan arsitektur model yang disesuaikan adalah karya orisinal. Dilarang keras menyalin, mendistribusikan, atau merekayasa balik (reverse engineering) tanpa izin tertulis dari pengembang.",
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// Open source packages
          const _SectionLabel(label: "Paket Open Source yang Digunakan"),
          const SizedBox(height: 10),
          ..._packages.map((p) => _PackageTile(pkg: p)),
        ],
      ),
    );
  }
}

/// Widget khusus untuk membuat list bernomor yang rapi seperti surat
class _NumberedParagraph extends StatelessWidget {
  final String number;
  final String title;
  final String content;

  const _NumberedParagraph({
    required this.number,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF18230F),
              height: 1.6,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF18230F).withOpacity(0.8),
                  height: 1.6,
                  fontFamily: 'Roboto', // Sesuaikan dengan font utama aplikasi Anda
                ),
                children: [
                  TextSpan(
                    text: "$title. ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18230F),
                    ),
                  ),
                  TextSpan(text: content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Package {
  final String name;
  final String license;
  const _Package({required this.name, required this.license});
}

class _PackageTile extends StatelessWidget {
  final _Package pkg;
  const _PackageTile({required this.pkg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF41B06E).withOpacity(0.12),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.inventory_2_rounded,
              color: Color(0xFF41B06E), size: 15),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              pkg.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF18230F),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF7F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              pkg.license,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF41B06E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF18230F).withOpacity(0.45),
        letterSpacing: 0.4,
      ),
    );
  }
}