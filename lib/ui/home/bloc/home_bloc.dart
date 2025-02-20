import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/models/todo.dart';

import '../../../domain/use_cases/todo_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoUseCase _todoUseCase;

  HomeBloc(this._todoUseCase) : super(HomeState.initial()) {
    on<GetTodoList>(_getTodoList);
  }

  FutureOr<void> _getTodoList(GetTodoList event, emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await _todoUseCase.getTodoList();
    result.fold(
      (error) {
        emit(state.copyWith(status: HomeStatus.error, error: error.toString()));
      },
      (data) {
        emit(
          state.copyWith(
            status: HomeStatus.success,
            onProgressTodos:
                data.where((element) => element.completed == false).toList(),
            completedTodos:
                data.where((element) => element.completed == true).toList(),
          ),
        );
      },
    );
  }
}
