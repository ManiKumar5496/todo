import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/views/utils/utils.dart';
import '../viewmodel/task_list_view_model.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<TaskListViewModel>(
            builder: (context, viewModel, child) {
              return ListView.builder(
                itemCount: viewModel.tasks.length,
                itemBuilder: (context, index) {
                  final task = viewModel.tasks[index];
                  var borderRadius = const BorderRadius.only(
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32));
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: borderRadius),
                      selectedTileColor: Colors.orange[100],
                      title: Text(task.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: task.isDone,
                            onChanged: (_) {
                              viewModel.toggleTask(index);
                            },
                          ),
                          GestureDetector(
                            child: const Icon(Icons.share),
                            onTap: () {
                              Utils.sendEmail(
                                  email: "",
                                  subject: "This is my todo task",
                                  body: "Please find my Todo Task");
                            },
                          ),
                          GestureDetector(
                            child: const Icon(Icons.delete),
                            onTap: () {
                              viewModel.deleteTask(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const AddTaskWidget(),
      ],
    );
  }
}

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  hintText: 'Enter task...',
                ),
              ),
            ),
            const SizedBox(width: 10),
            TextButton.icon(
              onPressed: () {
                final taskName = _controller.text;
                if (taskName.isNotEmpty) {
                  Provider.of<TaskListViewModel>(context, listen: false)
                      .addTask(taskName);
                  _controller.clear();
                }
              },
              icon: Icon(Icons.add, size: 18),
              label: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
