import 'package:dartz/dartz.dart';
import 'package:todo/data/repositories/todo_repository.dart';

import '../models/todo.dart';

class TodoUseCase {
  TodoUseCase(this._repository);
  final TodoRepository _repository;

  Future<Either<Exception, List<Todo>>> getTodoList() =>
      _repository.getTodoList();

  Future<Either<Exception, Todo>> createTodo(Todo todo) =>
      _repository.createTodo(todo);

  Future<Either<Exception, Todo>> updateTodo(Todo todo) =>
      _repository.updateTodo(todo);

  Future<Either<Exception, void>> deleteTodo(int id) =>
      _repository.deleteTodo(id);
}
