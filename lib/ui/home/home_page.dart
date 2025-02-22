// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/config/app_route.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/todo_form/todo_form.dart';
import 'package:todo/ui/widgets/home_skeleton_widget.dart';
import 'package:todo/ui/widgets/task_card_widget.dart';
import 'package:todo/ui/widgets/menu_title_widget.dart';
import 'package:todo/ui/widgets/onprogress_card_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:todo/utils/dialog_utils.dart';

import '../detail/detail_page.dart';
import '../bloc/todo_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          context.read<TodoBloc>().add(GetTodoList());
          return Future.delayed(Duration(seconds: 1));
        },
        child: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state.status == Status.error) {
              showErrorDialog(context, state.error!);
            }
          },
          builder: (context, state) {
            return switch (state.status) {
              Status.initial ||
              Status.loading ||
              Status.error =>
                HomeSkeletonWidget(),
              _ => CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text("Todo app"),
                      floating: true,
                      actions: _buildActions,
                    ),
                    SliverToBoxAdapter(child: _buildOnProgressTitle()),
                    SliverToBoxAdapter(
                      child: _buildOnProgressCard(state.onProgressTodos!),
                    ),
                    SliverToBoxAdapter(child: _buildCompletedTitle()),
                    _buildCompletedCard(state.completedTodos!),
                  ],
                )
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Haptics.vibrate(HapticsType.soft);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            enableDrag: true,
            builder: (context) => TodoForm(todoFormType: TodoFormType.create),
          );
        },
        label: Text("Create New"),
        icon: Icon(Icons.add),
      ).animate().scale(),
    );
  }

  SliverList _buildCompletedCard(List<Todo> todos) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TaskCardWidget(isCompleted: true, todo: todo).animate().slideX();
      },
      itemCount: todos.length,
    );
  }

  MenuTitleWidget _buildCompletedTitle() {
    return MenuTitleWidget(
      title: "Completed",
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onViewMoreTapped: () {
        Navigator.pushNamed(context, AppRoute.detail, arguments: {
          "type": DetailPageType.completed,
        });
      },
    );
  }

  MenuTitleWidget _buildOnProgressTitle() {
    return MenuTitleWidget(
      title: "On Progress",
      onViewMoreTapped: () {
        Navigator.pushNamed(context, AppRoute.detail, arguments: {
          "type": DetailPageType.onprogress,
        });
      },
    );
  }

  List<Widget> get _buildActions {
    final style = IconButton.styleFrom(
      side: BorderSide(width: 0.3, color: Colors.grey),
    );

    return [
      IconButton.outlined(
        onPressed: _showUnderConstructionToast,
        icon: Icon(Icons.calendar_month),
        style: style,
      ),
      SizedBox(width: 4),
      IconButton.outlined(
        onPressed: _showUnderConstructionToast,
        icon: Icon(Icons.notifications)
            .animate(onPlay: (controller) => controller.repeat())
            .shake(curve: Curves.easeInOutCirc),
        style: style,
      ),
      SizedBox(width: 16),
    ];
  }

  void _showUnderConstructionToast() async {
    await Haptics.vibrate(HapticsType.warning);
    toastification.show(
      context: context,
      title: Text('Under construction!'),
      autoCloseDuration: const Duration(seconds: 2),
      type: ToastificationType.warning,
    );
  }

  Widget _buildOnProgressCard(List<Todo> todos) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final todo = todos[index];
          return OnProgressCardWidget(
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
          );
        },
        itemCount: todos.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
