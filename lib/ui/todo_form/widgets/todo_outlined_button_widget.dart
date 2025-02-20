import 'package:flutter/material.dart';

class TodoOutlinedButtonWidget extends StatelessWidget {
  const TodoOutlinedButtonWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.sideColor,
    this.foregroundColor,
  });
  final String title;
  final VoidCallback? onPressed;
  final Color? sideColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: sideColor ?? Colors.blue),
          foregroundColor: foregroundColor ?? Colors.blue,
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
