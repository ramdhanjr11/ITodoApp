import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:todo/config/app_colors.dart';

class Todo extends Equatable {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  final String description = faker.lorem.sentence();
  final ColorEnum color;
  final String dateCreated;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  })  : color = ColorEnum.values[Random().nextInt(3)],
        dateCreated = DateFormat('EEEE, dd MMMM yyyy').format(
            faker.date.dateTimeBetween(DateTime(2025, 1, 1), DateTime.now()));

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
        completed,
        description,
        color,
        dateCreated,
      ];

  factory Todo.dummy() => Todo(
        userId: 1,
        id: 1,
        title: faker.lorem.sentence(),
        completed: false,
      );
}
