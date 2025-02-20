// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/bloc/todo_bloc.dart';
import 'package:todo/ui/widgets/detail_skeleton_widget.dart';
import 'package:todo/ui/widgets/task_card_widget.dart';
import 'package:todo/utils/dialog_utils.dart';

import '../../config/app_colors.dart';
import '../../utils/toast_utils.dart';
import '../todo_form/todo_form.dart';

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

            if (state.status == Status.updateIsCompletedSuccess) {
              showToastification(
                context,
                ToastificationType.success,
                HapticsType.success,
                "Task is done!",
              );
            }

            if (state.status == Status.deleteError ||
                state.status == Status.updateIsCompletedError) {
              showErrorDialog(context, state.error!);
            }
          },
          builder: (context, state) {
            return switch (state.status) {
              Status.loading || Status.error => DetailSkeletonWidget(),
              _ => CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text("On Progress task"),
                      floating: true,
                    ),
                    SliverList.builder(
                      itemBuilder: (context, index) {
                        final todo = state.onProgressTodos?[index];

                        return _buildOnProgressTaskCard(todo);
                      },
                      itemCount: state.onProgressTodos?.length,
                    )
                  ],
                )
            };
          },
        ),
      ),
    );
  }

  Dismissible _buildOnProgressTaskCard(Todo? todo) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          context.read<TodoBloc>().add(DeleteTodo(todo!.id));
        }

        if (direction == DismissDirection.endToStart) {
          final updatedTodo = todo!.copyWith(completed: true);
          context.read<TodoBloc>().add(UpdateCompleted(updatedTodo));
        }
      },
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
        todo: todo,
        onTap: (todo) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            enableDrag: true,
            builder: (context) => TodoForm(
              todoFormType: TodoFormType.update,
              todo: todo,
            ),
          );
        },
      ),
    );
  }
}
