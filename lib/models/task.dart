import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  Task({required this.title, required this.description});
}

//Command For Generating adabters for hive
//flutter packages pub run build_runner build