import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../../core/data/gulma_data.dart';
import '../../weed_spesific_info/pages/weed_specific_info.dart';

class WeedCard extends StatelessWidget {
  final Weed weed;
  final Color accentColor;

  const WeedCard({
    super.key,
    required this.weed,
    this.accentColor = const Color(0xFF41B06E),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushScreen(
          context,
          screen: WeedSpecificInfo(weed: weed),
          withNavBar: false,
        );
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0XFF57BA69).withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
              child: Container(
                height: 100,
                color: const Color(0xFFF4FCF0),
                child: weed.image.isNotEmpty
                    ? Image.network(
                        weed.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const _PlaceholderImage(),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const _PlaceholderImage();
                        },
                      )
                    : const _PlaceholderImage(),
              ),
            ),

            /// Bottom info area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weed.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF18230F),
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8F5E9),
      child: const Center(
        child: Icon(Icons.eco_rounded, color: Color(0xFF87D05F), size: 36),
      ),
    );
  }
}
