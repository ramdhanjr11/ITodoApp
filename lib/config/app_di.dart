import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:todo/data/repositories/todo_repository.dart';
import 'package:todo/data/services/api_service.dart';
import 'package:todo/domain/use_cases/todo_use_case.dart';
import 'package:todo/ui/bloc/todo_bloc.dart';

final di = GetIt.instance;

void setup() {
  di
    ..registerSingleton(_configureDio())
    ..registerSingleton(ApiService(dio: di()))
    ..registerSingleton<TodoRepository>(TodoRepositoryImpl(di()))
    ..registerSingleton(TodoUseCase(di()))
    ..registerSingleton(TodoBloc(di()));
}

Dio _configureDio() {
  final options = BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com/',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
  );
  final dio = Dio(options);
  dio.interceptors.add(PrettyDioLogger(enabled: kDebugMode));

  return dio;
}
