import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sate_management_bloc_cubit/controller/cubit/task_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'controller/todo_bloc.dart';
import 'models/todo_model.dart';

import 'package:uuid/uuid.dart';

var uuid = Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  print((await getTemporaryDirectory()).path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreenBloc());
  }
}

class HomeScreenBloc extends StatelessWidget {
  HomeScreenBloc({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "New Note",
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green.shade500, width: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        height: double.infinity,
                        child: BlocBuilder<TodoBloc, TodoState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                context.read<TodoBloc>().add(
                                  TodoAdding(
                                    TodoModel(id: uuid.v4(), content: controller.text.trim()),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(10),
                                ),
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Add"),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.todoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(state.todoList);
                          final TodoModel todo = state.todoList[index];
                          print("Todo: ${todo.isChecked}");
                          return ListTile(
                            key: ValueKey(todo.id),
                            leading: Checkbox(
                              value: todo.isChecked,
                              onChanged: (value) {
                                context.read<TodoBloc>().add(TodoToggle(todo.id));
                              },
                            ),
                            title: Text(
                              todo.content,
                              style: TextStyle(
                                color: todo.isChecked ? Colors.grey : Colors.black,
                                decoration: todo.isChecked
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                context.read<TodoBloc>().add(TodoRemoving(todo.id));
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreenCubit extends StatelessWidget {
  HomeScreenCubit({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "New Note",
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green.shade500, width: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        height: double.infinity,
                        child: BlocBuilder<TaskCubit, TaskState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                context.read<TaskCubit>().addTask(controller.text.trim());
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(10),
                                ),
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Add"),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.taskList.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(state.taskList);
                          final TodoModel todo = state.taskList[index];
                          print("Todo: ${todo.isChecked}");
                          return ListTile(
                            key: ValueKey(todo.id),
                            leading: Checkbox(
                              value: todo.isChecked,
                              onChanged: (value) {
                                context.read<TaskCubit>().toggleTask(todo.id);
                              },
                            ),
                            title: Text(
                              todo.content,
                              style: TextStyle(
                                color: todo.isChecked ? Colors.grey : Colors.black,
                                decoration: todo.isChecked
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                context.read<TaskCubit>().removeTask(todo.id);
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
