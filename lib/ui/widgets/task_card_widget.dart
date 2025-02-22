import 'package:faker/faker.dart' as fake;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/utils/dummy_data.dart';

import '../../config/app_colors.dart';
import '../../domain/models/todo.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    super.key,
    required this.isCompleted,
    this.color,
    this.todo,
    this.onTap,
  });
  final Todo? todo;
  final bool isCompleted;
  final Color? color;
  final Function(Todo)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!(todo!) : null,
      child: Container(
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
              color: color ?? AppColors.green,
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
                    _buildTitleAndDescription(context),
                    Divider(),
                    _buildDateTime()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _buildDateTime() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: todo?.dateCreated ??
                DateFormat.EEEE().format(DummyData.fakeDateTime),
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(
            text: DateFormat.jm().format(DummyData.fakeDateTime),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Expanded _buildTitleAndDescription(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo?.title ?? fake.faker.lorem.sentence(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  todo?.description ?? fake.faker.lorem.sentence(),
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
              color: isCompleted ? Colors.blue : AppColors.pink,
            ),
            child: Icon(
              isCompleted ? Icons.done : Icons.schedule,
              color: Colors.white,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}
