import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mastawesha/constants.dart';
import 'package:mastawesha/controllers/user_controller.dart';
import 'package:mastawesha/screens/home_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kMainPadding),
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Mastawesha"),
              SizedBox(height: size.height * 0.04),
              TextField(controller: _userNameController, decoration: buildDecoration(hintText: "username")),
              TextField(controller: _emailController, decoration: buildDecoration(hintText: "email")),
              TextField(controller: _passwordController, decoration: buildDecoration(hintText: "password")),
              TextField(controller: _ageController, decoration: buildDecoration(hintText: "age")),
              SizedBox(height: size.height * 0.04),
              ElevatedButton(
                onPressed: () {
                  //!Register user
                  if (_userNameController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _ageController.text.isNotEmpty) {
                    Provider.of<UserController>(context, listen: false)
                        .registerUser(_userNameController.text, _emailController.text, _passwordController.text, _ageController.text);
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, size.height * 0.06),
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration buildDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.transparent)),
      // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.transparent)),
      // filled: true,
      // fillColor: Colors.grey.shade100,
    );
  }
}
