import 'package:flutter/material.dart';

class SaveDialog extends StatelessWidget {
  final String result;

  const SaveDialog({super.key, required this.result});

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
              color: const Color(0xFF41B06E).withOpacity(0.2),
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
              /// 🔥 ICON
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF18230F), Color(0xFF41B06E)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.bookmark_rounded,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              /// TITLE
              const Text(
                "Save to History",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF18230F),
                ),
              ),

              const SizedBox(height: 8),

              /// MESSAGE
              Text(
                'Save result "$result" to history?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF18230F).withOpacity(0.55),
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
                            "Cancel",
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

                  /// SAVE
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF41B06E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
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