import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;

  const DeleteDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = "Hapus",
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEF9651).withOpacity(0.18),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🔥 ICON WARNING
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEF9651), Color(0xFFE57373)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE57373).withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.delete_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(height: 20),

              /// TITLE
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF18230F),
                ),
              ),

              const SizedBox(height: 8),

              /// MESSAGE
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF18230F).withOpacity(0.55),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              /// BUTTONS
              Row(
                children: [
                  /// CANCEL
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, false),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4FCF0),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF87D05F).withOpacity(0.4),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Batal",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF41B06E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// DELETE
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE57373).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFE57373),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            confirmText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFE57373),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}