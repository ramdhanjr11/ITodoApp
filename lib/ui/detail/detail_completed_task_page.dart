import 'package:flutter/material.dart';
import 'package:todo/config/app_colors.dart';

import '../widgets/task_card_widget.dart';

class DetailCompletedTaskPage extends StatefulWidget {
  const DetailCompletedTaskPage({super.key});

  @override
  State<DetailCompletedTaskPage> createState() =>
      _DetailCompletedTaskPageState();
}

class _DetailCompletedTaskPageState extends State<DetailCompletedTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () => Future.delayed(Duration(seconds: 2)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Completed task"),
              floating: true,
            ),
            SliverList.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) => setState(() {}),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: AppColors.pink,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: TaskCardWidget(isCompleted: true),
                );
              },
              itemCount: 20,
            )
          ],
        ),
      ),
    );
  }
}
