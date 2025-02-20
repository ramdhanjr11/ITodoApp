import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/todo.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends Equatable {
  @JsonKey(name: 'userId')
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const TodoModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      userId: todo.userId,
      id: todo.id,
      title: todo.title,
      completed: todo.completed,
    );
  }

  Todo toEntity() {
    return Todo(
      userId: userId,
      id: id,
      title: title,
      completed: completed,
    );
  }

  @override
  List<Object?> get props => [userId, id, title, completed];
}
