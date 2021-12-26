import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mastawesha/constants.dart';
import 'package:mastawesha/controllers/task_controller.dart';
import 'package:mastawesha/controllers/user_controller.dart';
import 'package:mastawesha/screens/register_screen.dart';
import 'package:mastawesha/utils/string_helpers.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kMainPadding),
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<UserController>(
                    builder: (context, value, child) => Text(value.user!.name.toCapitalized(), style: Theme.of(context).textTheme.headline5),
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () {
                        Provider.of<UserController>(context, listen: false).removeUser();
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => RegisterScreen()));
                      },
                      child: CircleAvatar(child: Text('A', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white)), radius: size.height * 0.022)),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Consumer<TaskController>(
                builder: (context, value, child) => Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: value.tasks.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: kHorizontalMargin, vertical: kVerticalMargin),
                      padding: const EdgeInsets.all(kMainPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade200, offset: const Offset(2, 5), blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value.tasks[index].title.toCapitalized()),
                          Text(value.tasks[index].description.toCapitalized()),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Container(
                padding: const EdgeInsets.all(kMainPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: _titleController, decoration: const InputDecoration(hintText: "Title")),
                    TextField(controller: _descriptioncontroller, decoration: const InputDecoration(hintText: "Description")),
                    TextButton(
                      onPressed: () {
                        if (_titleController.text.isNotEmpty && _descriptioncontroller.text.isNotEmpty) {
                          Provider.of<TaskController>(context, listen: false).addTask(_titleController.text, _descriptioncontroller.text);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
