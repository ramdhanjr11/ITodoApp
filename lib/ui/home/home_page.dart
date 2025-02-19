// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/config/app_route.dart';
import 'package:todo/ui/widgets/task_card_widget.dart';
import 'package:todo/ui/widgets/menu_title_widget.dart';
import 'package:todo/ui/widgets/on_progress_card_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../config/app_colors.dart';
import '../detail/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Todo app"),
              floating: true,
              actions: _buildActions,
            ),
            SliverToBoxAdapter(
              child: MenuTitleWidget(
                title: "On Progress",
                onViewMoreTapped: () {
                  Navigator.pushNamed(context, AppRoute.detail, arguments: {
                    "type": DetailPageType.onprogress,
                  });
                },
              ),
            ),
            SliverToBoxAdapter(child: _buildHorizontalOnProgressCard()),
            SliverToBoxAdapter(
              child: MenuTitleWidget(
                title: "Completed",
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                onViewMoreTapped: () {
                  Navigator.pushNamed(context, AppRoute.detail, arguments: {
                    "type": DetailPageType.completed,
                  });
                },
              ),
            ),
            SliverList.builder(
              itemBuilder: (context, index) {
                return TaskCardWidget(isCompleted: true).animate().slideX();
              },
              itemCount: 10,
            ),
          ],
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
            builder: (context) {
              return _buildBottomSheet();
            },
          );
        },
        label: Text("Create New"),
        icon: Icon(Icons.add),
      ).animate().scale(),
    );
  }

  Widget _buildBottomSheet() {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            color: AppColors.background,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        width: 80,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "New Task Todo",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),
                    _buildTextField(
                      title: "Title Task",
                      hintText: "Add title task..",
                    ),
                    SizedBox(height: 12),
                    _buildTextField(
                      title: "Description",
                      hintText: "Add description..",
                      maxLines: 3,
                    ),
                    SizedBox(height: 12),
                    Row(
                      spacing: 12,
                      children: [
                        _buildDateTimeField(
                          title: "Date",
                          hintText:
                              DateFormat('dd/mm/yy').format(DateTime.now()),
                          prefixIcon: Icons.date_range,
                        ),
                        _buildDateTimeField(
                          title: "Time",
                          hintText: DateFormat.Hm().format(DateTime.now()),
                          prefixIcon: Icons.schedule,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      spacing: 12,
                      children: [
                        _buildCancelButton(),
                        _buildCreateButton(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Expanded _buildCreateButton() {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            log("Sukses");
          }
        },
        child: Text("Create"),
      ),
    );
  }

  Expanded _buildCancelButton() {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.blue),
          foregroundColor: Colors.blue,
        ),
        onPressed: () => Navigator.pop(context),
        child: Text("Cancel"),
      ),
    );
  }

  Expanded _buildDateTimeField({
    String? title,
    String? hintText,
    IconData? prefixIcon,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            title ?? "Title",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              hintText: hintText,
              prefixIcon: Icon(prefixIcon),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 15),
            ),
            enabled: false,
          ),
        ],
      ),
    );
  }

  Column _buildTextField({
    String? title,
    String? hintText,
    int? maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "Title",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.11),
              hintText: hintText,
            ),
            maxLines: maxLines,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
      ],
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
