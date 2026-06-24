import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Universal header untuk semua halaman WeedCheck.
///
/// Penggunaan:
/// ```dart
/// // Tanpa back button (halaman utama)
/// AppHeader(title: "WeedCheck")
///
/// // Dengan back button (halaman detail/sub)
/// AppHeader(title: "Hasil Deteksi", showBack: true)
///
/// // Dengan back button + aksi kanan
/// AppHeader(
///   title: "Beri Rating",
///   showBack: true,
///   action: IconButton(icon: Icon(Icons.share), onPressed: () {}),
/// )
/// ```
class AppHeader extends StatelessWidget {
  final String title;
  final bool showBack;
  final Widget? action;

  const AppHeader({
    super.key,
    required this.title,
    this.showBack = false,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// Back button — kiri (hanya jika showBack: true)
                if (showBack)
                  /// Title — selalu rata tengah
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),

                /// Action button — kanan (opsional)
                if (action != null) Positioned(right: 4, child: action!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── HEADER ────────────────────────────────────────────────────────────────────
class InfoHeader extends StatelessWidget {
  const InfoHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF246A40),
            Color(0xFF41B06E),
          ],
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
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          child: Row(
            children: [
              /// Logo
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFFFDD34).withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Color(0xFFFFDD34),
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              /// Judul
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Info",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    "Informasi aplikasi WeedCheck",
                    style: TextStyle(
                      color: Color(0xFFFFE432),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
