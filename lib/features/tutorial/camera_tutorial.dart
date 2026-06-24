import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CameraTutorial {
  static void start(
    BuildContext context, {
    required GlobalKey infoKey,
    required GlobalKey flashKey,
    required GlobalKey galleryKey,
    required GlobalKey flipKey,
    required GlobalKey captureKey,
  }) {
    ShowCaseWidget.of(
      context,
    ).startShowCase([infoKey, flashKey, galleryKey, flipKey, captureKey]);
  }

  static Widget tutorial({
    required GlobalKey key,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Showcase(
      key: key,
      title: title,
      description: description,
      disableMovingAnimation: false,
      targetBorderRadius: BorderRadius.circular(12),
      tooltipBorderRadius: BorderRadius.circular(12),
      tooltipPadding: const EdgeInsets.all(16),
      titleTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      descriptionPadding: const EdgeInsets.only(top: 4),
      descriptionTextAlign: TextAlign.center,
      descTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      tooltipBackgroundColor: const Color(0xff2E7D32),
      child: child,
    );
  }
}
