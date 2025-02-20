import 'package:dio/dio.dart';
import 'package:todo/data/models/todo_model.dart';

class ApiService {
  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://jsonplaceholder.typicode.com/',
              ),
            );

  final Dio _dio;

  Future<List<TodoModel>> getTodos() async {
    try {
      final response = await _dio.get('todos');
      return List<TodoModel>.from(
        response.data.map((x) => TodoModel.fromJson(x)),
      );
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<TodoModel> createTodo(TodoModel todo) async {
    try {
      final response = await _dio.post('todos', data: todo.toJson());
      return TodoModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<TodoModel> updateTodo(TodoModel todo) async {
    try {
      final response = await _dio.put('todos/${todo.id}', data: todo.toJson());
      return TodoModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await _dio.delete('todos/$id');
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
