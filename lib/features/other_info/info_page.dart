import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:weedcheck/features/other_info/orisinal_page.dart';
import 'package:weedcheck/features/other_info/widget/header_info_widget.dart';
import 'package:weedcheck/features/other_info/widget/menu_item_widget.dart';
import 'about_page.dart';
import 'guide_page.dart';
import 'rating_page.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6FBF7),
        body: Column(
          children: [
            /// Header
            InfoHeader(),

            /// Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Menu list
                    MenuItem(
                      icon: Icons.info_outline_rounded,
                      iconColor: const Color(0xFF41B06E),
                      iconBg: const Color(0xFFEAF7F0),
                      title: "Tentang Aplikasi",
                      subtitle: "Versi, tujuan, dan tim pengembang",
                      onTap: () => _push(context, const AboutPage()),
                    ),
                    const SizedBox(height: 4),
                    MenuItem(
                      icon: Icons.menu_book_rounded,
                      iconColor: const Color(0xFF87D05F),
                      iconBg: const Color(0xFFF0FAE8),
                      title: "Panduan Penggunaan",
                      subtitle: "Cara menggunakan WeedCheck",
                      onTap: () => _push(context, const GuidePage()),
                    ),
                    const SizedBox(height: 4),
                    MenuItem(
                      icon: Icons.star_rounded,
                      iconColor: const Color(0xFFFFDD34),
                      iconBg: const Color(0xFFFFFBE6),
                      title: "Beri Rating",
                      subtitle: "Kirim ulasan & masukan ke developer",
                      onTap: () => _push(context, const RatingPage()),
                    ),
                    const SizedBox(height: 4),
                    MenuItem(
                      icon: Icons.verified_rounded,
                      iconColor: const Color(0xFFEF9651),
                      iconBg: const Color(0xFFFFF3E8),
                      title: "Orisinalitas",
                      subtitle: "Lisensi, sumber data, dan hak cipta",
                      onTap: () => _push(context, const LegalDisclaimerPage()),
                      isLast: true,
                    ),

                    const SizedBox(height: 24),

                    /// Version footer
                    const _VersionFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _push(BuildContext context, Widget page) {
    pushScreen(context, screen: page, withNavBar: false);
  }
}

// ─── SECTION LABEL ─────────────────────────────────────────────────────────────
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
        letterSpacing: 0.5,
      ),
    );
  }
}

// ─── VERSION FOOTER ────────────────────────────────────────────────────────────
class _VersionFooter extends StatelessWidget {
  const _VersionFooter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "WeedCheck v1.0.0 · 2026",
        style: TextStyle(
          fontSize: 11,
          color: const Color(0xFF18230F).withOpacity(0.3),
        ),
      ),
    );
  }
}
