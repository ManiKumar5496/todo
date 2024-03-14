import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/task_list_view_model.dart';
import 'package:todo_app/views/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          TaskListViewModel(), // Provide the TaskListViewModel instance
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            centerTitle: true,
            title: const Text('To-Do List'),
          ),
          body: const TaskListScreen(),
        ),
      ),
    );
  }
}
