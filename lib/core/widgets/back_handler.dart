import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BackHandler {
  static DateTime? lastBackPressTime;

  static Future<bool> handleBack({
    required BuildContext context,
    required PersistentTabController controller,
  }) async {

    /// 🔁 kalau bukan HOME → balik ke HOME
    if (controller.index != 0) {
      controller.jumpToTab(0);
      return false;
    }

    /// ⏱️ double tap exit
    DateTime now = DateTime.now();

    if (lastBackPressTime == null ||
        now.difference(lastBackPressTime!) > Duration(seconds: 2)) {

      lastBackPressTime = now;

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Tekan sekali lagi untuk keluar")),
      // );

      return false;
    }

    /// POP UP KELUAR APLIKASI
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Keluar"),
        content: Text("Apakah Anda ingin keluar dari aplikasi?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Tidak"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Ya"),
          ),
        ],
      ),
    );
  }
}