import 'dart:io';
import 'package:flutter/material.dart';
import '../models/history_entry_model.dart';

class HistoryCard extends StatelessWidget {
  final HistoryEntry entry;
  final VoidCallback onDelete;
  final VoidCallback onTap; // ← baru

  const HistoryCard({
    super.key,
    required this.entry,
    required this.onDelete,
    required this.onTap,
  });

  String _formatDate(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}  $h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final file = File(entry.imagePath);
    final imageExists = file.existsSync();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF41B06E).withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: imageExists
                  ? Image.file(file, width: 90, height: 90, fit: BoxFit.cover)
                  : Container(
                      width: 90,
                      height: 90,
                      color: const Color(0xFFEEF7EC),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: Color(0xFF87D05F),
                      ),
                    ),
            ),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.weedName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF18230F),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: Color(0xFF8FB88A),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(entry.detectedAt),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF8FB88A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Delete button
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0F0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xFFE57373),
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
