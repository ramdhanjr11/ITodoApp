import 'package:flutter/material.dart';
import 'package:todo/ui/widgets/completed_card_widget.dart';
import 'package:todo/ui/widgets/menu_title_widget.dart';
import 'package:todo/ui/widgets/on_progress_card_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Todo app"),
            floating: true,
            actions: _buildActions,
          ),
          SliverToBoxAdapter(child: MenuTitleWidget(title: "On Progress")),
          SliverToBoxAdapter(child: _buildHorizontalOnProgressCard()),
          SliverToBoxAdapter(
            child: MenuTitleWidget(
              title: "Completed",
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              return CompletedCardWidget().animate().slideX();
            },
            itemCount: 10,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {},
        label: Text("Create New"),
        icon: Icon(Icons.add),
      ).animate().scale(),
    );
  }

  List<Widget> get _buildActions {
    return [
      IconButton.outlined(
        onPressed: () {},
        icon: Icon(Icons.calendar_month),
        style: IconButton.styleFrom(
          side: BorderSide(width: 0.3, color: Colors.grey),
        ),
      ),
      SizedBox(width: 4),
      IconButton.outlined(
        onPressed: () {},
        icon: Icon(Icons.notifications)
            .animate(onPlay: (controller) => controller.repeat())
            .shake(curve: Curves.easeInOutCirc),
        style: IconButton.styleFrom(
          side: BorderSide(width: 0.3, color: Colors.grey),
        ),
      ),
      SizedBox(width: 16),
    ];
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
