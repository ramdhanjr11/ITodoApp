// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:toastification/toastification.dart';

void showToastification(BuildContext context, ToastificationType toastType,
    HapticsType hapticType, String title) async {
  await Haptics.vibrate(hapticType);
  toastification.show(
    context: context,
    title: Text(title),
    type: ToastificationType.success,
    autoCloseDuration: const Duration(seconds: 2),
  );
}
