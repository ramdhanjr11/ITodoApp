import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../config/app_colors.dart';
import 'task_card_widget.dart';

class DetailSkeletonWidget extends StatelessWidget {
  const DetailSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Skeletonizer(child: Text("On Progress task")),
          floating: true,
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return Skeletonizer(
              child: TaskCardWidget(
                isCompleted: false,
                color: AppColors.pink,
              ),
            );
          },
          itemCount: 20,
        )
      ],
    );
  }
}
