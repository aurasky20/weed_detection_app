import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/camera_detection/presentation/pages/camera_page.dart';
import '../../features/history/presentation/pages/history_page.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      tabs: [
        /// 🏠 HOME
        PersistentTabConfig(
          screen: HomePage(),
          item: ItemConfig(
            icon: Icon(Icons.home),
            title: "Home",
            activeForegroundColor: Colors.green,
            inactiveForegroundColor: Colors.grey,
          ),
        ),

        /// 📸 CAMERA (kotak)
        PersistentTabConfig(
          screen: HomePage(),
          item: ItemConfig(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.camera_alt, color: Colors.white),
            ),
            title: "Camera",
          ),
        ),

        /// 📜 HISTORY
        PersistentTabConfig(
          screen: HistoryPage(),
          item: ItemConfig(
            icon: Icon(Icons.history),
            title: "Riwayat",
            activeForegroundColor: Colors.green,
            inactiveForegroundColor: Colors.grey,
          ),
        ),
      ],

      onTabChanged: (index) {
      if (index == 1) {
        _controller.jumpToTab(0);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => CameraPage(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    },

      /// 🎨 STYLE 14
      navBarBuilder: (navBarConfig) => Style14BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}