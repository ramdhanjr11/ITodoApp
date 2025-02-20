import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xffF8F9FD);
  static const Color yellow = Color(0xffFEE8C9);
  static const Color green = Color(0xff8ED29F);
  static const Color pink = Color(0xffF0C4CE);
  static const Color purple = Color(0xffA4ABFF);

  static const List<Color> colors = [yellow, green, pink, purple];

  static ColorEnum getRandomColor = ColorEnum.values[Random().nextInt(3)];
  static Color getRandomColor2 = colors[Random().nextInt(3)];
}

enum ColorEnum {
  yellow(value: AppColors.yellow),
  green(value: AppColors.green),
  pink(value: AppColors.pink),
  purple(value: AppColors.purple);

  const ColorEnum({required this.value});
  final Color value;
}
