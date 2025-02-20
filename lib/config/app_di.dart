import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/data/repositories/todo_repository.dart';
import 'package:todo/data/services/api_service.dart';
import 'package:todo/domain/use_cases/todo_use_case.dart';

final di = GetIt.instance;

void setup() {
  di.registerSingleton(configureDio());
  di.registerSingleton(ApiService(dio: di()));
  di.registerSingleton<TodoRepository>(TodoRepositoryImpl(di()));
  di.registerSingleton(TodoUseCase(di()));
}

Dio configureDio() {
  final options = BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com/',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
  );
  return Dio(options);
}
