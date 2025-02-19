import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/app_colors.dart';

class CompletedCardWidget extends StatelessWidget {
  CompletedCardWidget({super.key});
  final fakeDateTime =
      faker.date.dateTimeBetween(DateTime(2025, 1, 1), DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Container(
            width: 12,
            color: AppColors.pink,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                faker.lorem.sentence(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                faker.lorem.sentence(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: DateFormat.EEEE().format(fakeDateTime),
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 8)),
                        TextSpan(
                          text: DateFormat.jm().format(fakeDateTime),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
