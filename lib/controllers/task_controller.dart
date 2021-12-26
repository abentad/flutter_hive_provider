import 'package:flutter/cupertino.dart';
import 'package:mastawesha/models/task.dart';
import 'package:mastawesha/utils/hive_boxes.dart';

class TaskController extends ChangeNotifier {
  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  final taskBox = Boxes.getTasksBox();

  void addTask(String title, String description) {
    Task newTask = Task(title: title, description: description);
    taskBox.add(newTask);
    _tasks.add(newTask);
    notifyListeners();
  }
}
