import 'package:flutter/material.dart';
import '../../../core/data/gulma_data.dart';
import 'weed_card.dart';

class WeedSection extends StatelessWidget {
  final String title;

  const WeedSection({super.key, required this.title});

  /// Maps title to an icon for visual distinction
  IconData _iconForTitle(String title) {
    if (title.contains("Lebar")) return Icons.eco_rounded;
    if (title.contains("Sempit")) return Icons.eco_rounded;
    return Icons.eco_rounded;
  }

  Color _colorForTitle(String title) {
    if (title.contains("Lebar")) return const Color(0xFF41B06E);
    if (title.contains("Sempit")) return const Color(0xFF87D05F);
    return const Color(0xFFEF9651);
  }

  @override
  Widget build(BuildContext context) {
    final weeds = GulmaData.data[title] ?? [];
    final color = _colorForTitle(title);

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                /// Colored accent icon
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(_iconForTitle(title), color: color, size: 18),
                ),
                const SizedBox(width: 10),

                /// Title
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18230F),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// Horizontal Card List
          SizedBox(
            height: 160,
            child: weeds.isEmpty
                ? Center(
                    child: Text(
                      "Belum ada data",
                      style: TextStyle(
                        color: const Color(0xFF18230F).withOpacity(0.4),
                        fontSize: 13,
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: weeds.length,
                    itemBuilder: (context, index) {
                      return WeedCard(weed: weeds[index], accentColor: color);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
