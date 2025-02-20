part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  const HomeState(
    this.status,
    this.onProgressTodos,
    this.completedTodos,
    this.error,
  );

  final HomeStatus status;
  final List<Todo>? onProgressTodos;
  final List<Todo>? completedTodos;
  final String? error;

  factory HomeState.initial() => HomeState(
        HomeStatus.initial,
        null,
        null,
        null,
      );

  HomeState copyWith({
    HomeStatus? status,
    List<Todo>? onProgressTodos,
    List<Todo>? completedTodos,
    String? error,
  }) {
    return HomeState(
      status ?? this.status,
      onProgressTodos ?? this.onProgressTodos,
      completedTodos ?? this.completedTodos,
      error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, onProgressTodos, completedTodos, error];
}
