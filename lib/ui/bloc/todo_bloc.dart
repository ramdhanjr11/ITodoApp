import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/models/todo.dart';

import '../../domain/use_cases/todo_use_case.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoUseCase _todoUseCase;

  TodoBloc(this._todoUseCase) : super(TodoState.initial()) {
    on<GetTodoList>(_getTodoList);
    on<UpdateTodo>(_updateTodo);
    on<UpdateCompleted>(_updateCompleted);
    on<CreateTodo>(_createTodo);
    on<DeleteTodo>(_deleteTodo);
  }

  FutureOr<void> _getTodoList(GetTodoList event, emit) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _todoUseCase.getTodoList();

    result.fold(
      (error) {
        emit(state.copyWith(status: Status.error, error: error.toString()));
      },
      (data) {
        emit(
          state.copyWith(
            status: Status.success,
            onProgressTodos:
                data.where((element) => element.completed == false).toList(),
            completedTodos:
                data.where((element) => element.completed == true).toList(),
          ),
        );
      },
    );
  }

  FutureOr<void> _updateTodo(UpdateTodo event, emit) async {
    emit(state.copyWith(status: Status.loadingUpdate));

    final result = await _todoUseCase.updateTodo(event.todo);

    result.fold(
      (error) {
        emit(state.copyWith(
            status: Status.updateError, error: error.toString()));
      },
      (data) {
        emit(state.copyWith(status: Status.updateSuccess));
      },
    );
  }

  FutureOr<void> _updateCompleted(UpdateCompleted event, emit) async {
    emit(state.copyWith(status: Status.loadingUpdate));

    final result = await _todoUseCase.updateTodo(event.todo);

    result.fold(
      (error) {
        emit(state.copyWith(
            status: Status.updateIsCompletedError, error: error.toString()));
      },
      (data) {
        emit(state.copyWith(status: Status.updateIsCompletedSuccess));
      },
    );
  }

  FutureOr<void> _createTodo(CreateTodo event, emit) async {
    emit(state.copyWith(status: Status.loadingCreate));

    final result = await _todoUseCase.createTodo(event.todo);

    result.fold(
      (error) {
        emit(state.copyWith(
            status: Status.createError, error: error.toString()));
      },
      (data) {
        emit(state.copyWith(status: Status.createSucces));
      },
    );
  }

  FutureOr<void> _deleteTodo(DeleteTodo event, emit) async {
    emit(state.copyWith(status: Status.loadingDelete));

    final result = await _todoUseCase.deleteTodo(event.id);

    result.fold(
      (error) {
        emit(state.copyWith(
            status: Status.deleteError, error: error.toString()));
      },
      (data) {
        emit(state.copyWith(status: Status.deleteSuccess));
      },
    );
  }
}
