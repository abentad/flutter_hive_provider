import 'package:hive/hive.dart';
import 'package:mastawesha/constants.dart';
import 'package:mastawesha/models/task.dart';
import 'package:mastawesha/models/user.dart';

class Boxes {
  static Box<User> getUsersBox() => Hive.box<User>(kUserHiveBox);
  static Box<Task> getTasksBox() => Hive.box<Task>(kTaskHiveBox);
}
