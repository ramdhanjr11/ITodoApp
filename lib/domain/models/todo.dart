import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:todo/config/app_colors.dart';

import '../../utils/dummy_data.dart';

class Todo extends Equatable {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  final String description = faker.lorem.sentence();
  final ColorEnum color = AppColors.getRandomColor;
  final String dateCreated =
      DateFormat('EEEE, dd MMMM yyyy').format(DummyData.fakeDateTime);

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

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
}
