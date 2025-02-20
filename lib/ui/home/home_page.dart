// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/config/app_route.dart';
import 'package:todo/ui/todo_form/todo_create_form.dart';
import 'package:todo/ui/widgets/task_card_widget.dart';
import 'package:todo/ui/widgets/menu_title_widget.dart';
import 'package:todo/ui/widgets/onprogress_card_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../detail/detail_page.dart';
import 'bloc/home_bloc.dart';

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
          context.read<HomeBloc>().add(GetTodoList());
          return Future.delayed(Duration(seconds: 1));
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text("Todo app"),
                  floating: true,
                  actions: _buildActions,
                ),
                SliverToBoxAdapter(
                  child: state.status == HomeStatus.loading
                      ? Skeletonizer(child: _buildOnProgressTitle())
                      : _buildOnProgressTitle(),
                ),
                SliverToBoxAdapter(
                  child: state.status == HomeStatus.loading
                      ? Skeletonizer(child: _buildHorizontalOnProgressCard())
                      : _buildHorizontalOnProgressCard(),
                ),
                SliverToBoxAdapter(
                  child: state.status == HomeStatus.loading
                      ? Skeletonizer(child: _buildCompletedTitle())
                      : _buildCompletedTitle(),
                ),
                state.status == HomeStatus.loading
                    ? Skeletonizer.sliver(
                        child: SliverList.builder(
                        itemBuilder: (context, index) {
                          return TaskCardWidget(isCompleted: true)
                              .animate()
                              .slideX();
                        },
                        itemCount: 10,
                      ))
                    : SliverList.builder(
                        itemBuilder: (context, index) {
                          return TaskCardWidget(isCompleted: true)
                              .animate()
                              .slideX();
                        },
                        itemCount: 10,
                      ),
              ],
            );
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
            builder: (context) => TodoCreateForm(),
          );
        },
        label: Text("Create New"),
        icon: Icon(Icons.add),
      ).animate().scale(),
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

  Widget _buildHorizontalOnProgressCard() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return OnProgressCardWidget().animate().shake();
        },
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12),
      ),
    ).animate().slideX();
  }
}
