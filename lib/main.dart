import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_bloc_cubit/controllers/task_bloc.dart';
import 'package:state_management_bloc_cubit/controllers/task_event.dart';
import 'package:state_management_bloc_cubit/controllers/task_state.dart';

import 'models/task_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: "Flutter Demo Home Page"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final TextEditingController controller = TextEditingController();
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocProvider(
        create: (BuildContext context) => TaskBloc(),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (BuildContext context, state) {
            return Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: "Enter a task"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isEmpty) return;
                    context.read<TaskBloc>().add(TaskAddEvent(controller.text));
                    controller.clear();
                  },
                  child: const Text("Add task"),
                ),
                Expanded(
                  child: state.taskList.isEmpty?Center(child: const Text("No tasks"),): ListView.builder(
                    itemCount: state.taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final TaskModel task = state.taskList[index];
                      return ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            context.read<TaskBloc>().add(TaskToggleEvent(task.id));
                          },
                        ),
                        title: Text(task.title),
                        trailing: IconButton(
                          onPressed: () {
                            context.read<TaskBloc>().add(TaskRemoveEvent(task.id));
                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
