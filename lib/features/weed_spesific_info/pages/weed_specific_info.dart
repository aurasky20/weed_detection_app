import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weedcheck/features/weed_spesific_info/widgets/infoSection_widget.dart';
import 'package:weedcheck/features/weed_spesific_info/widgets/invalidImage_widget.dart';
import 'package:weedcheck/features/weed_spesific_info/widgets/label_widget.dart';
import '../../../core/data/gulma_data.dart';

class WeedSpecificInfo extends StatelessWidget {
  final Weed weed;
  const WeedSpecificInfo({super.key, required this.weed});

  String _getCategoryForWeed(Weed weed) {
  // Mencari di setiap entry Map (Key: Nama Kategori, Value: List Weed)
  for (var entry in GulmaData.data.entries) {
    if (entry.value.contains(weed)) {
      return entry.key; // Mengembalikan "Gulma Daun Lebar", dsb.
    }
  }
  return "Spesifikasi Gulma"; // Fallback jika tidak ditemukan
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// ─── HERO IMAGE + COLLAPSING APP BAR ───
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            stretch: true,
            backgroundColor: const Color(0xFF18230F),
            systemOverlayStyle: SystemUiOverlayStyle.light,

            /// Back button
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),

            /// Collapsing title
            title: Text(
              "Spesifikasi Gulma",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),

            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  /// Weed Image
                  weed.image.isNotEmpty
                      ? Image.network(
                          weed.image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const HeroPlaceholder(),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const HeroPlaceholder();
                          },
                        )
                      : const HeroPlaceholder(),

                  /// Gradient scrim bottom
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            const Color(0xFF18230F).withOpacity(0.6),
                            const Color(0xFF18230F).withOpacity(0.92),
                          ],
                          stops: const [0.0, 0.45, 0.75, 1.0],
                        ),
                      ),
                    ),
                  ),

                  /// Weed name tag at bottom of hero
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Category chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF41B06E).withOpacity(0.85),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.eco_rounded,
                                  color: Colors.white, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                _getCategoryForWeed(weed),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        /// Weed name
                        Text(
                          weed.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ─── BODY CONTENT ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Quick info chips row
                  QuickInfoRow(),

                  const SizedBox(height: 24),

                  /// Herbisida Section
                  InfoSection(
                    icon: Icons.science_rounded,
                    iconColor: const Color(0xFFEF9651),
                    iconBg: const Color(0xFFFFF3E8),
                    title: "Herbisida",
                    content: weed.herbiside,
                    accentColor: const Color(0xFFEF9651),
                  ),

                  const SizedBox(height: 16),

                  /// Deskripsi Section
                  InfoSection(
                    icon: Icons.menu_book_rounded,
                    iconColor: const Color(0xFF41B06E),
                    iconBg: const Color(0xFFF0FAF4),
                    title: "Deskripsi",
                    content: weed.desc,
                    accentColor: const Color(0xFF41B06E),
                  ),

                  const SizedBox(height: 32),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

