import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mastawesha/constants.dart';
import 'package:mastawesha/controllers/task_controller.dart';
import 'package:mastawesha/controllers/user_controller.dart';
import 'package:mastawesha/models/task.dart';
import 'package:mastawesha/models/user.dart';
import 'package:mastawesha/screens/home_screen.dart';
import 'package:mastawesha/screens/register_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<User>(kUserHiveBox);
  await Hive.openBox<Task>(kTaskHiveBox);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(create: (context) => UserController()),
        ChangeNotifierProvider<TaskController>(create: (context) => TaskController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isRegistered = false;
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  void checkUser() {
    setState(() {
      isRegistered = Provider.of<UserController>(context, listen: false).isUserRegistered();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isRegistered ? HomeScreen() : RegisterScreen(),
      theme: ThemeData(
        primaryColor: Colors.purple,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.black),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
