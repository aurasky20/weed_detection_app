import 'package:flutter/material.dart';
import 'package:weedcheck/features/other_info/infosub_page.dart';
import 'package:weedcheck/features/other_info/widget/developer_card_widget.dart';
import 'package:weedcheck/features/other_info/widget/info_card_widget.dart';
import 'package:weedcheck/features/other_info/widget/version_footer_widget.dart';

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
                  child: const Icon(
                    Icons.eco_rounded,
                    color: Color(0xFFFFDD34),
                    size: 40,
                  ),
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

          InfoCard(
            icon: Icons.grass_rounded,
            title: "Apa itu Gulma?",
            content:
                "Gulma merupakan tanaman pengganggu yang tumbuh di lahan pertanian dan dapat menurunkan produktivitas tanaman budidaya. Gulma bersaing dengan tanaman utama dalam memperoleh sinar matahari, air, unsur hara, serta ruang tumbuh. Selain itu, gulma mampu tumbuh dan berkembang secara alami tanpa sengaja ditanam, sehingga populasinya dapat meningkat dengan cepat. Oleh karena itu, keberadaan gulma perlu dikendalikan agar tidak menghambat pertumbuhan tanaman dan mengurangi hasil panen.",
          ),

          // const SizedBox(height: 12),

          // InfoCard(
          //   icon: Icons.flag_rounded,
          //   title: "Tujuan Aplikasi",
          //   content:
          //       "WeedCheck hadir untuk membantu petani dan peneliti mengidentifikasi jenis gulma secara cepat dan akurat menggunakan teknologi kecerdasan buatan (AI) berbasis model YOLO.",
          // ),

          // const SizedBox(height: 12),

          // InfoCard(
          //   icon: Icons.psychology_rounded,
          //   title: "Teknologi",
          //   content:
          //       "Aplikasi ini menggunakan model deteksi objek YOLOv8 yang dilatih pada dataset gulma lokal Indonesia, dijalankan secara offline di perangkat menggunakan TensorFlow Lite.",
          // ),

          const SizedBox(height: 12),

          InfoCard(
            icon: Icons.grass_rounded,
            title: "Kategori Gulma",
            content:
                "WeedCheck mampu mengenali tiga kategori utama gulma:\n• Gulma Daun Lebar\n• Gulma Daun Sempit\n• Gulma Teki-teki",
          ),

          const SizedBox(height: 12),

          const DeveloperInfoCard(),

          const SizedBox(height: 24),

          /// Version info row
          const VersionFooter(),
        ],
      ),
    );
  }
}
