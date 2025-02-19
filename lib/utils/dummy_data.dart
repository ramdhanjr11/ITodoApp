import 'package:faker/faker.dart';

class DummyData {
  static final fakeDateTime =
      faker.date.dateTimeBetween(DateTime(2025, 1, 1), DateTime.now());
  static final fakeImage = "https://picsum.photos/seed/picsum/200/300";
}
