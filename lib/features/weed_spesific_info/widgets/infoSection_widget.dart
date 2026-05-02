import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String content;
  final Color accentColor;

  const InfoSection({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.content,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(
          color: accentColor.withOpacity(0.20),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Card Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF18230F),
                    letterSpacing: -0.2,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accentColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),

          /// Divider
          Container(
            height: 1,
            color: accentColor.withOpacity(0.08),
          ),

          /// Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              content.isNotEmpty ? content : "Informasi tidak tersedia.",
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF18230F),
                height: 1.65,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}