import 'package:flutter/material.dart';

class MenuTitleWidget extends StatelessWidget {
  final String? title;
  final int? count;
  final VoidCallback? onViewMoreTapped;
  final EdgeInsets? padding;

  const MenuTitleWidget({
    super.key,
    this.title,
    this.count,
    this.onViewMoreTapped,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                WidgetSpan(child: SizedBox(width: 4)),
                if (count != null)
                  TextSpan(
                    text: "($count)",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: onViewMoreTapped,
            child: Text(
              "View More",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
