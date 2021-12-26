import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mastawesha/constants.dart';
import 'package:mastawesha/models/user.dart';
import 'package:mastawesha/utils/hive_boxes.dart';
import 'package:mastawesha/utils/string_helpers.dart';

class UserController extends ChangeNotifier {
  final userBox = Boxes.getUsersBox();
  final tasksBox = Boxes.getTasksBox();
  User? user;

  UserController() {
    if (userBox.isNotEmpty) {
      user = userBox.values.toList().cast<User>()[0];
      print("User: " + user!.name.toCapitalized());
    }
  }

  bool isUserRegistered() {
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

  void registerUser(String name, String email, String password, String age) {
    userBox.clear();
    User newUser = User(name: name, age: age, email: email, password: password);
    userBox.add(newUser);
    //using specific key
    // userBox.put('keyName', value);
    notifyListeners();
  }

  void removeUser() {
    userBox.clear();
    tasksBox.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    //closes all opened boxes
    // Hive.close();
    Hive.box(kUserHiveBox).close();
    super.dispose();
  }
}
