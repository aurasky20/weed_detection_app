import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:weedcheck/core/widgets/back_handler.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/camera_detection/pages/camera_page.dart';
import '../../features/history/pages/history_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late final PersistentTabController _controller;
  DateTime? lastBackPressTime;

  /// 🔥 kalau di HOME → double tap untuk exit
  DateTime now = DateTime.now();

  // if (lastBackPressTime == null ||
  //     now.difference(lastBackPressTime!) > Duration(seconds: 2)) {
  //   lastBackPressTime = now;

  //   return false;
  // }

  /// 🔥 tampilkan dialog exit
//   return await showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text("Keluar"),
//       content: Text("Apakah Anda ingin keluar dari aplikasi?"),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context, false),
//           child: Text("Tidak"),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context, true),
//           child: Text("Ya"),
//         ),
//       ],
//     ),
//   );
// }

  @override
  void initState() {
    super.initState();

    /// 🔥 DEFAULT HOME
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BackHandler.handleBack(
        context: context,
        controller: _controller,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      
        body: Stack(
          children: [
            /// 🔽 NAVBAR + PAGE
            PersistentTabView(
              controller: _controller,
              backgroundColor: Colors.transparent,
      
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
      
                /// ❌ CAMERA TAB (DUMMY)
                PersistentTabConfig(
                  screen: HomePage(),
                  item: ItemConfig(
                    activeForegroundColor: Colors.white,
                    inactiveForegroundColor: Colors.white,
                    icon: SizedBox.shrink(), // 🔥 kosongkan
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
      
              /// ❌ NONAKTIFKAN CAMERA TAB
              onTabChanged: (index) {
                if (index == 1) {
                  _controller.jumpToTab(0);
                }
              },
      
              navBarBuilder: (navBarConfig) => Style16BottomNavBar(
                navBarConfig: navBarConfig,
                navBarDecoration: NavBarDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ),
      
            /// 🔥 FLOATING CAMERA BUTTON (INI KUNCINYA)
            Positioned(
              bottom: 25,
              left: MediaQuery.of(context).size.width / 2 - 35,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => CameraPage(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    )
                  ).then((_) {
                    _controller.jumpToTab(0);
                  });
                },
      
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        blurRadius: 12,
                        // offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}