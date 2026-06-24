import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class StreamingTutorial {
  static void start(
    BuildContext context, {
    required GlobalKey infoKey,
    required GlobalKey flashKey,
    required GlobalKey detectionKey,
    required GlobalKey fpsKey,
    required GlobalKey modelKey,
    required GlobalKey flipKey,
    required GlobalKey maxItemKey,
    required GlobalKey confidenceKey,
    required GlobalKey iouKey,
  }) {
    ShowCaseWidget.of(context).startShowCase([
      infoKey,
      flashKey,
      detectionKey,
      fpsKey,
      modelKey,
      flipKey,
      maxItemKey,
      confidenceKey,
      iouKey,
    ]);
  }

  static Widget tutorial({
    required GlobalKey key,
    required String title,
    required String description,
    required Widget child,
    int? totalSteps,
    int? currentStep,
  }) {
    return Showcase(
      key: key,
      title: title,
      description: description,
      disableMovingAnimation: false,
      targetBorderRadius: BorderRadius.circular(8),
      targetPadding: const EdgeInsets.all(8),
      tooltipBorderRadius: BorderRadius.circular(12),
      tooltipPadding: const EdgeInsets.all(16),
      titleTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      descriptionPadding: const EdgeInsets.only(top: 4, bottom: 8),
      descriptionTextAlign: TextAlign.center,
      descTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      tooltipBackgroundColor: const Color(0xff2E7D32),

      // tooltipActions: [
      //   TooltipActionButton(
      //     type: TooltipDefaultActionType.skip,
      //     name: 'Skip',
      //     textStyle: const TextStyle(color: Colors.black),
      //     backgroundColor: Colors.white.withOpacity(0.5),
      //     borderRadius: BorderRadius.circular(8),
      //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      //   ),
      // ],
      child: child,
    );
  }
}
