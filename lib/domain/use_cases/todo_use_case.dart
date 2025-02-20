import 'package:dartz/dartz.dart';
import 'package:todo/data/repositories/todo_repository.dart';

import '../../data/models/todo_model.dart';

class TodoUseCase {
  TodoUseCase(this._repository);
  final TodoRepository _repository;

  Future<Either<Exception, List<TodoModel>>> getTodoList() =>
      _repository.getTodoList();

  Future<Either<Exception, TodoModel>> createTodo(TodoModel todo) =>
      _repository.createTodo(todo);

  Future<Either<Exception, TodoModel>> updateTodo(TodoModel todo) =>
      _repository.updateTodo(todo);

  Future<Either<Exception, void>> deleteTodo(int id) =>
      _repository.deleteTodo(id);
}
