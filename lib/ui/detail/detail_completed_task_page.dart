// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/config/app_colors.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/widgets/detail_skeleton_widget.dart';
import 'package:todo/utils/dialog_utils.dart';
import 'package:todo/utils/toast_utils.dart';

import '../bloc/todo_bloc.dart';
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
        onRefresh: () {
          context.read<TodoBloc>().add(GetTodoList());
          return Future.delayed(Duration(seconds: 2));
        },
        child: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) async {
            if (state.status == Status.deleteSuccess) {
              showToastification(
                context,
                ToastificationType.success,
                HapticsType.success,
                "Delete success!",
              );
            }

            if (state.status == Status.deleteError) {
              showErrorDialog(context, state.error!);
            }
          },
          builder: (context, state) {
            return switch (state.status) {
              Status.loading || Status.error => DetailSkeletonWidget(),
              _ => CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text("Completed task"),
                      floating: true,
                    ),
                    SliverList.builder(
                      itemBuilder: (context, index) {
                        final todo = state.completedTodos?[index];
                        return _buildCompletedTaskCard(todo);
                      },
                      itemCount: state.completedTodos?.length,
                    )
                  ],
                )
            };
          },
        ),
      ),
    );
  }

  Dismissible _buildCompletedTaskCard(Todo? todo) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        context.read<TodoBloc>().add(DeleteTodo(todo!.id));
      },
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
      child: TaskCardWidget(isCompleted: true, todo: todo),
    );
  }
}
