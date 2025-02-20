// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

import '../ui/bloc/todo_bloc.dart';

void showErrorDialog(BuildContext context, String error) async {
  await Haptics.vibrate(HapticsType.warning);

  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: Text("Error"),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<TodoBloc>().add(GetTodoList());
            },
            child: Text("Retry"),
          ),
        ],
      );
    },
  );
}
