import 'package:flutter/material.dart';

class DeveloperInfoCard extends StatelessWidget {
  const DeveloperInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontSize: 15,
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    );

    const valueStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF18230F),
      fontWeight: FontWeight.w700,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF41B06E).withOpacity(0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFF246A40),
                  size: 18,
                ),
                SizedBox(width: 6),
                Text(
                  "Informasi Pengembang",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF246A40),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          _DeveloperItem(
            icon: Icons.person,
            label: "Nama",
            value: "AURA SASI KIRANA DHARMA ACINTYA",
          ),

          const SizedBox(height: 18),

          _DeveloperItem(
            icon: Icons.school,
            label: "Institusi",
            value: "Politeknik Elektronika Negeri Surabaya (PENS)",
          ),

          const SizedBox(height: 18),

          _DeveloperItem(
            icon: Icons.code,
            label: "GitHub",
            value: "github.com/aurasky20",
          ),
        ],
      ),
    );
  }
}

class _DeveloperItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DeveloperItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontSize: 12,
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    );

    const valueStyle = TextStyle(
      fontSize: 12,
      color: Color(0xFF18230F),
      fontWeight: FontWeight.w700,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF246A40), size: 20),

        const SizedBox(width: 14),

        SizedBox(width: 70, child: Text(label, style: labelStyle)),

        const SizedBox(width: 14),

        Expanded(child: Text(value, style: valueStyle)),
      ],
    );
  }
}
