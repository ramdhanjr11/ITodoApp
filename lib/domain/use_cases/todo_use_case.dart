import 'package:dartz/dartz.dart';
import 'package:todo/data/repositories/todo_repository.dart';
import 'package:todo/domain/models/error.dart';

import '../models/todo.dart';

class TodoUseCase {
  TodoUseCase(this._repository);
  final TodoRepository _repository;

  Future<Either<Error, List<Todo>>> getTodoList() => _repository.getTodoList();

  Future<Either<Error, Todo>> createTodo(Todo todo) =>
      _repository.createTodo(todo);

  Future<Either<Error, Todo>> updateTodo(Todo todo) =>
      _repository.updateTodo(todo);

  Future<Either<Error, void>> deleteTodo(int id) => _repository.deleteTodo(id);
}
