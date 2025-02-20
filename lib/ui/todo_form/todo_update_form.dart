import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/ui/todo_form/widgets/todo_datetime_field_widget.dart';
import 'package:todo/ui/todo_form/widgets/todo_elevated_button_widget.dart';
import 'package:todo/ui/todo_form/widgets/todo_form_textfield_widget.dart';
import 'package:todo/ui/todo_form/widgets/todo_outlined_button_widget.dart';

import '../../config/app_colors.dart';
import '../../domain/models/todo.dart';

class TodoUpdateForm extends StatefulWidget {
  const TodoUpdateForm({super.key, required this.todo});
  final Todo todo;

  @override
  State<TodoUpdateForm> createState() => _TodoUpdateFormState();
}

class _TodoUpdateFormState extends State<TodoUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          "Update Task Todo",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(),
                    TodoFormTextfieldWidget(
                      controller: titleController,
                      title: "Title Task",
                      hintText: "Update title task..",
                    ),
                    SizedBox(height: 12),
                    TodoFormTextfieldWidget(
                      controller: descriptionController,
                      title: "Description",
                      hintText: "Update description..",
                      maxLines: 3,
                    ),
                    SizedBox(height: 12),
                    Row(
                      spacing: 12,
                      children: [
                        TodoDatetimeFieldWidget(
                          title: "Date",
                          hintText:
                              DateFormat('dd/mm/yy').format(DateTime.now()),
                          prefixIcon: Icons.date_range,
                        ),
                        TodoDatetimeFieldWidget(
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
                        TodoOutlinedButtonWidget(
                          title: "Cancel",
                          onPressed: () => Navigator.pop(context),
                        ),
                        TodoElevatedButtonWidget(
                          title: "Update",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                        )
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
}
