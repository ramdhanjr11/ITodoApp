import 'package:flutter/material.dart';

class TodoElevatedButtonWidget extends StatelessWidget {
  const TodoElevatedButtonWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.blue,
          foregroundColor: foregroundColor ?? Colors.white,
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
