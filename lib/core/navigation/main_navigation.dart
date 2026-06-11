import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:weedcheck/core/widgets/back_handler.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/camera_detection/pages/camera_page.dart';
import '../../features/streaming/pages/camera_inference_screen.dart';
import '../../features/history/pages/history_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late final PersistentTabController _controller;
  bool _showCameraMenu = false;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  void _toggleCameraMenu() {
    setState(() => _showCameraMenu = !_showCameraMenu);
  }

  void _closeCameraMenu() {
    if (_showCameraMenu) setState(() => _showCameraMenu = false);
  }

  void _openCamera() {
    _closeCameraMenu();
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => CameraPage(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ).then((_) => _controller.jumpToTab(0));
  }

  void _openStreaming() {
    _closeCameraMenu();
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CameraInferenceScreen(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ).then((_) => _controller.jumpToTab(0));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_showCameraMenu) {
          _closeCameraMenu();
          return false;
        }
        return BackHandler.handleBack(
          context: context,
          controller: _controller,
        );
      },
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

                /// CAMERA TAB (placeholder, handled by floating button)
                PersistentTabConfig(
                  screen: HomePage(),
                  item: ItemConfig(
                    activeForegroundColor: Colors.transparent,
                    inactiveForegroundColor: Colors.transparent,
                    icon: SizedBox.shrink(),
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
                  _toggleCameraMenu();
                } else {
                  _closeCameraMenu();
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

            /// 🌑 BACKGROUND SCRIM — tap luar untuk tutup menu
            if (_showCameraMenu)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeCameraMenu,
                  child: Container(color: Colors.black.withOpacity(0.35)),
                ),
              ),

            /// 🟢 FLOATING CAMERA OPTION BUTTONS
            if (_showCameraMenu) ...[
              /// Streaming button (kiri)
              _FloatingMenuButton(
                bottom: 105,
                left: MediaQuery.of(context).size.width / 2 - 85,
                icon: Icons.videocam_rounded,
                label: 'Streaming',
                color: Color(0xFF7DC953),
                onTap: _openStreaming,
              ),

              /// Camera button (kanan)
              _FloatingMenuButton(
                bottom: 105,
                left: MediaQuery.of(context).size.width / 2 + 15,
                icon: Icons.camera_alt_rounded,
                label: 'Camera',
                color: Colors.orange.shade400,
                onTap: _openCamera,
              ),
            ],

            /// 🔥 FLOATING CAMERA BUTTON (tengah navbar)
            Positioned(
              bottom: 25,
              left: MediaQuery.of(context).size.width / 2 - 35,
              child: GestureDetector(
                onTap: _toggleCameraMenu,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _showCameraMenu
                        ? Colors.green.shade800
                        : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Icon(
                    _showCameraMenu
                        ? Icons.close_rounded
                        : Icons.camera_alt,
                    color: Colors.white,
                    size: 30,
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

/// Widget tombol floating menu (Streaming / Camera)
class _FloatingMenuButton extends StatelessWidget {
  final double bottom;
  final double left;
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _FloatingMenuButton({
    required this.bottom,
    required this.left,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}