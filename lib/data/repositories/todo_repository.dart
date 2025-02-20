import 'package:dartz/dartz.dart';
import 'package:todo/data/services/api_error_handling.dart';
import 'package:todo/data/services/api_service.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/domain/models/error.dart';

import '../models/todo_model.dart';

abstract class TodoRepository {
  Future<Either<Error, List<Todo>>> getTodoList();
  Future<Either<Error, Todo>> createTodo(Todo todo);
  Future<Either<Error, Todo>> updateTodo(Todo todo);
  Future<Either<Error, void>> deleteTodo(int id);
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._apiService);
  final ApiService _apiService;

  @override
  Future<Either<Error, Todo>> createTodo(Todo todo) async {
    try {
      final result = await _apiService.createTodo(TodoModel.fromEntity(todo));
      return Right(result.toEntity());
    } catch (e) {
      final errorMessage = ApiErrorHandling.handleApiError(e);
      return Left(Error(message: errorMessage));
    }
  }

  @override
  Future<Either<Error, void>> deleteTodo(int id) async {
    try {
      final result = await _apiService.deleteTodo(id);
      return Right(result);
    } catch (e) {
      final errorMessage = ApiErrorHandling.handleApiError(e);
      return Left(Error(message: errorMessage));
    }
  }

  @override
  Future<Either<Error, List<Todo>>> getTodoList() async {
    try {
      final result = await _apiService.getTodos();
      final entities = result.map((e) => e.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      final errorMessage = ApiErrorHandling.handleApiError(e);
      return Left(Error(message: errorMessage));
    }
  }

  @override
  Future<Either<Error, Todo>> updateTodo(Todo todo) async {
    try {
      final result = await _apiService.updateTodo(TodoModel.fromEntity(todo));
      return Right(result.toEntity());
    } catch (e) {
      final errorMessage = ApiErrorHandling.handleApiError(e);
      return Left(Error(message: errorMessage));
    }
  }
}
