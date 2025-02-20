part of 'todo_bloc.dart';

enum Status {
  initial,
  loading,
  success,
  error,
  loadingCreate,
  loadingUpdate,
  loadingDelete,
  createSucces,
  updateSuccess,
  deleteSuccess
}

class TodoState extends Equatable {
  const TodoState(
    this.status,
    this.onProgressTodos,
    this.completedTodos,
    this.error,
  );

  final Status status;
  final List<Todo>? onProgressTodos;
  final List<Todo>? completedTodos;
  final String? error;

  factory TodoState.initial() => TodoState(
        Status.initial,
        null,
        null,
        null,
      );

  TodoState copyWith({
    Status? status,
    List<Todo>? onProgressTodos,
    List<Todo>? completedTodos,
    String? error,
  }) {
    return TodoState(
      status ?? this.status,
      onProgressTodos ?? this.onProgressTodos,
      completedTodos ?? this.completedTodos,
      error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, onProgressTodos, completedTodos, error];
}
