part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetTodoList extends TodoEvent {}

class CreateTodo extends TodoEvent {
  final Todo todo;
  const CreateTodo(this.todo);
}

class UpdateTodo extends TodoEvent {
  final Todo todo;
  const UpdateTodo(this.todo);
}

class UpdateCompleted extends TodoEvent {
  final Todo todo;
  const UpdateCompleted(this.todo);
}

class DeleteTodo extends TodoEvent {
  final int id;
  const DeleteTodo(this.id);
}
