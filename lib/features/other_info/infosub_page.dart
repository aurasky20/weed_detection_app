import 'package:flutter/material.dart';
import 'package:weedcheck/features/other_info/widget/header_info_widget.dart';

/// Scaffold reusable untuk semua sub-halaman Info.
/// Sudah pakai AppHeader dengan showBack: true.
class InfoSubpageScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? headerAction;

  const InfoSubpageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.headerAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF7),
      body: Column(
        children: [
          AppHeader(title: title, showBack: true, action: headerAction),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}