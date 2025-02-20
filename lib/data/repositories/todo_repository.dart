import 'package:dartz/dartz.dart';
import 'package:todo/data/services/api_service.dart';

import '../models/todo_model.dart';

abstract class TodoRepository {
  Future<Either<Exception, List<TodoModel>>> getTodoList();
  Future<Either<Exception, TodoModel>> createTodo(TodoModel todo);
  Future<Either<Exception, TodoModel>> updateTodo(TodoModel todo);
  Future<Either<Exception, void>> deleteTodo(int id);
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._apiService);
  final ApiService _apiService;

  @override
  Future<Either<Exception, TodoModel>> createTodo(TodoModel todo) async {
    try {
      final result = await _apiService.createTodo(todo);
      return Right(result);
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
  Future<Either<Exception, List<TodoModel>>> getTodoList() async {
    try {
      final result = await _apiService.getTodos();
      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, TodoModel>> updateTodo(TodoModel todo) async {
    try {
      final result = await _apiService.updateTodo(todo);
      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
