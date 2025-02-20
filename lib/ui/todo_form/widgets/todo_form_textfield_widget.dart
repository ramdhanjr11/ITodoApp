import 'package:flutter/material.dart';

class TodoFormTextfieldWidget extends StatelessWidget {
  const TodoFormTextfieldWidget({
    super.key,
    this.title,
    this.hintText,
    this.maxLines,
    this.initialValue,
    this.controller,
  });

  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final String? initialValue;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "Title",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.11),
              hintText: hintText,
            ),
            maxLines: maxLines,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            initialValue: initialValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
