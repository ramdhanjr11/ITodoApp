import 'package:flutter/material.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/todo_form/todo_create_form.dart';

import 'todo_update_form.dart';

enum TodoFormType { create, update }

class TodoForm extends StatelessWidget {
  const TodoForm({
    super.key,
    required this.todoFormType,
    this.todo,
  });
  final TodoFormType todoFormType;
  final Todo? todo;

  @override
  Widget build(BuildContext context) {
    return switch (todoFormType) {
      TodoFormType.create => TodoCreateForm(),
      TodoFormType.update => TodoUpdateForm(todo: todo!),
    };
  }
}
