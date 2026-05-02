import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:weedcheck/core/widgets/exit_dialog.dart';

class BackHandler {
  static DateTime? _lastBackPressTime;

  static Future<bool> handleBack({
    required BuildContext context,
    required PersistentTabController controller,
  }) async {
    /// 🔁 If not on HOME tab → jump to HOME
    if (controller.index != 0) {
      controller.jumpToTab(0);
      return false;
    }

    /// ⏱️ Double-tap to trigger exit dialog
    final now = DateTime.now();
    final isFirstPress = _lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2);

    if (isFirstPress) {
      _lastBackPressTime = now;

      /// Show snackbar hint on first press
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.info_outline_rounded, color: Color(0xFFFFDD34), size: 16),
              SizedBox(width: 8),
              Text(
                "Tekan sekali lagi untuk keluar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF18230F),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(seconds: 2),
          elevation: 6,
        ),
      );

      return false;
    }

    final shouldExit = await _showExitDialog(context) ?? false;

      if (shouldExit) {

      SystemNavigator.pop();
    }

    return false;
  }

  static Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => const ExitDialog(),
    );
  }
}