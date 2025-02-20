import 'package:dartz/dartz.dart';
import 'package:todo/data/services/api_service.dart';
import 'package:todo/domain/models/todo.dart';

import '../models/todo_model.dart';

abstract class TodoRepository {
  Future<Either<Exception, List<Todo>>> getTodoList();
  Future<Either<Exception, Todo>> createTodo(Todo todo);
  Future<Either<Exception, Todo>> updateTodo(Todo todo);
  Future<Either<Exception, void>> deleteTodo(int id);
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._apiService);
  final ApiService _apiService;

  @override
  Future<Either<Exception, Todo>> createTodo(Todo todo) async {
    try {
      final result = await _apiService.createTodo(TodoModel.fromEntity(todo));
      return Right(result.toEntity());
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteTodo(int id) async {
    try {
      final result = await _apiService.deleteTodo(id);
      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Todo>>> getTodoList() async {
    try {
      final result = await _apiService.getTodos();
      final entities = result.map((e) => e.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Todo>> updateTodo(Todo todo) async {
    try {
      final result = await _apiService.updateTodo(TodoModel.fromEntity(todo));
      return Right(result.toEntity());
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
