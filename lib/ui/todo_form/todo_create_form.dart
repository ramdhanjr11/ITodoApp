// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/todo_form/widgets/todo_datetime_field_widget.dart';
import 'package:todo/ui/todo_form/widgets/todo_elevated_button_widget.dart';
import 'package:todo/ui/todo_form/widgets/todo_form_textfield_widget.dart';
import 'package:todo/ui/todo_form/widgets/todo_outlined_button_widget.dart';

import '../../config/app_colors.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/loading_dialog_widget.dart';

class TodoCreateForm extends StatefulWidget {
  const TodoCreateForm({super.key});

  @override
  State<TodoCreateForm> createState() => _TodoCreateFormState();
}

class _TodoCreateFormState extends State<TodoCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) async {
        if (state.status == Status.createSucces) {
          Navigator.pop(context);
          await Haptics.vibrate(HapticsType.success);
          toastification.show(
            context: context,
            title: Text("Success to create new todo task!"),
            type: ToastificationType.success,
          );
        }

        if (state.status == Status.loadingCreate) {
          showAdaptiveDialog(
            context: context,
            builder: (context) => LoadingDialogWidget(),
          ).then((value) => Navigator.pop(context));
        }
      },
      child: Wrap(
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
                      TodoFormTextfieldWidget(
                        controller: titleController,
                        title: "Title Task",
                        hintText: "Add title task..",
                      ),
                      SizedBox(height: 12),
                      TodoFormTextfieldWidget(
                        controller: descriptionController,
                        title: "Description",
                        hintText: "Add description..",
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
                            title: "Create",
                            onPressed: _handleOnCreate,
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
      ),
    );
  }

  void _handleOnCreate() {
    if (_formKey.currentState!.validate()) {
      final todo = Todo(
        userId: 201,
        id: 201,
        title: titleController.text.trim(),
        completed: false,
      );

      context.read<TodoBloc>().add(CreateTodo(todo));
    }
  }
}
