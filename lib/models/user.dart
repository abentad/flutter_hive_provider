import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  User({required this.name, required this.age, required this.email, required this.password});
}


//Command For Generating adabters for hive
//flutter packages pub run build_runner build