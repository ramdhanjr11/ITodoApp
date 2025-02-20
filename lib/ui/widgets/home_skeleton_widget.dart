import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/models/todo.dart';
import 'menu_title_widget.dart';
import 'onprogress_card_widget.dart';
import 'task_card_widget.dart';

class HomeSkeletonWidget extends StatelessWidget {
  const HomeSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Skeletonizer(child: Text("Todo app")),
          floating: true,
          actions: _buildActions,
        ),
        SliverToBoxAdapter(child: _buildTitleSkeleton()),
        SliverToBoxAdapter(child: _buildOnProgressCardSkeleton()),
        SliverToBoxAdapter(child: _buildTitleSkeleton()),
        _buildCompletedCardSkeleton(),
      ],
    );
  }

  Skeletonizer _buildCompletedCardSkeleton() {
    return Skeletonizer.sliver(
        child: SliverList.builder(
      itemBuilder: (context, index) {
        return TaskCardWidget(isCompleted: true);
      },
      itemCount: 10,
    ));
  }

  Widget _buildTitleSkeleton() {
    return Skeletonizer(
      child: MenuTitleWidget(
        title: "Completed",
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        onViewMoreTapped: null,
      ),
    );
  }

  List<Widget> get _buildActions {
    final style = IconButton.styleFrom(
      side: BorderSide(width: 0.3, color: Colors.grey),
    );

    return [
      Skeletonizer(
        child: IconButton.outlined(
          onPressed: null,
          icon: Icon(Icons.calendar_month),
          style: style,
        ),
      ),
      SizedBox(width: 4),
      Skeletonizer(
        child: IconButton.outlined(
          onPressed: null,
          icon: Icon(Icons.notifications),
          style: style,
        ),
      ),
      SizedBox(width: 16),
    ];
  }

  Widget _buildOnProgressCardSkeleton() {
    return Skeletonizer(
      child: SizedBox(
        height: 280,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return OnProgressCardWidget(todo: Todo.dummy());
          },
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
