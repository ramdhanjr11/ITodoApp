import 'package:flutter/material.dart';
import 'package:todo/ui/widgets/task_card_widget.dart';

import '../../config/app_colors.dart';

class DetailOnprogressTaskPage extends StatefulWidget {
  const DetailOnprogressTaskPage({super.key});

  @override
  State<DetailOnprogressTaskPage> createState() =>
      _DetailOnprogressTaskPageState();
}

class _DetailOnprogressTaskPageState extends State<DetailOnprogressTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () => Future.delayed(Duration(seconds: 2)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("On Progress task"),
              floating: true,
            ),
            SliverList.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) => setState(() {}),
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
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: AppColors.green,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: TaskCardWidget(
                    isCompleted: false,
                    color: AppColors.pink,
                  ),
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
