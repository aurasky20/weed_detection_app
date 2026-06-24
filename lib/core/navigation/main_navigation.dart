import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:weedcheck/core/widgets/back_handler.dart';
import 'package:weedcheck/features/other_info/info_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/camera_detection/pages/camera_page.dart';
import '../../features/streaming/pages/camera_inference_screen.dart';

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

  void _toggleCameraMenu() =>
      setState(() => _showCameraMenu = !_showCameraMenu);

  void _closeCameraMenu() {
    if (_showCameraMenu) setState(() => _showCameraMenu = false);
  }

  Future<void> _openPage(Widget page) async {
    _closeCameraMenu();
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
    _controller.jumpToTab(0);
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
            /// ── Main NavBar + Pages
            PersistentTabView(
              controller: _controller,
              backgroundColor: Colors.transparent,
              tabs: [
                /// 🏠 Home
                PersistentTabConfig(
                  screen: const HomePage(),
                  item: ItemConfig(
                    icon: const Icon(Icons.home_rounded),
                    title: "Home",
                    activeForegroundColor: const Color(0xFF41B06E),
                    inactiveForegroundColor: Colors.grey,
                  ),
                ),

                /// Camera placeholder (handled by floating button)
                PersistentTabConfig(
                  screen: const HomePage(),
                  item: ItemConfig(
                    activeForegroundColor: Colors.transparent,
                    inactiveForegroundColor: Colors.transparent,
                    icon: const SizedBox.shrink(),
                  ),
                ),

                /// ℹ️ Info
                PersistentTabConfig(
                  screen: const InfoPage(),
                  item: ItemConfig(
                    icon: const Icon(Icons.info_outline_rounded),
                    title: "Info",
                    activeForegroundColor: const Color(0xFF41B06E),
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
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ),

            /// ── Scrim when camera menu is open
            if (_showCameraMenu)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeCameraMenu,
                  child: Container(
                      color: Colors.black.withOpacity(0.35)),
                ),
              ),

            /// ── Floating menu buttons
            if (_showCameraMenu) ...[
              _FloatingMenuButton(
                bottom: 108,
                left: MediaQuery.of(context).size.width / 2 - 88,
                icon: Icons.videocam_rounded,
                label: 'Streaming',
                color: const Color(0xFF87D05F),
                onTap: () => _openPage(const CameraInferenceScreen()),
              ),
              _FloatingMenuButton(
                bottom: 108,
                left: MediaQuery.of(context).size.width / 2 + 18,
                icon: Icons.camera_alt_rounded,
                label: 'Kamera',
                color: const Color(0xFFEF9651),
                onTap: () => _openPage(CameraPage()),
              ),
            ],

            /// ── Floating camera button (center)
            Positioned(
              bottom: 26,
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: GestureDetector(
                onTap: _toggleCameraMenu,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _showCameraMenu
                          ? [const Color(0xFF18230F), const Color(0xFF246A40)]
                          : [const Color(0xFF246A40), const Color(0xFF41B06E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF41B06E).withOpacity(0.45),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    _showCameraMenu
                        ? Icons.close_rounded
                        : Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 28,
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

// ─── FLOATING MENU BUTTON ──────────────────────────────────────────────────────
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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.45),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}