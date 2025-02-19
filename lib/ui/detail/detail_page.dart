import 'package:flutter/material.dart';
import 'package:todo/ui/detail/detail_completed_task_page.dart';

import 'detail_onprogress_task_page.dart';

enum DetailPageType { completed, onprogress }

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.type});
  final DetailPageType type;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      DetailPageType.completed => DetailCompletedTaskPage(),
      DetailPageType.onprogress => DetailOnprogressTaskPage(),
    };
  }
}
