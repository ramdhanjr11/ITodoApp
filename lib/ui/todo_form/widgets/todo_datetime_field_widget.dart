import 'package:flutter/material.dart';

class TodoDatetimeFieldWidget extends StatelessWidget {
  const TodoDatetimeFieldWidget({
    super.key,
    this.title,
    this.hintText,
    this.prefixIcon,
  });
  final String? title;
  final String? hintText;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            title ?? "Title",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              hintText: hintText,
              prefixIcon: Icon(prefixIcon),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 15),
            ),
            enabled: false,
          ),
        ],
      ),
    );
  }
}
