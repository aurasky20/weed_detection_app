import 'package:flutter/material.dart';

class _QuickChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── QUICK INFO ROW ────────────────────────────────────────────────────────────
class QuickInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QuickChip(
          icon: Icons.warning_amber_rounded,
          label: "Berbahaya",
          color: const Color(0xFFEF9651),
        ),
        const SizedBox(width: 8),
        _QuickChip(
          icon: Icons.agriculture_rounded,
          label: "Lahan Sawah",
          color: const Color(0xFF41B06E),
        ),
        const SizedBox(width: 8),
        _QuickChip(
          icon: Icons.water_drop_rounded,
          label: "Air & Kering",
          color: const Color(0xFF87D05F),
        ),
      ],
    );
  }
}
