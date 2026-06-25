// ─── VERSION FOOTER ────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

class VersionFooter extends StatelessWidget {
  const VersionFooter();

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
