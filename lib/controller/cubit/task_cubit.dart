import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_sate_management_bloc_cubit/models/todo_model.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'task_state.dart';

var uuid = Uuid();

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TasksInitial());

  void addTask(String content) {
    final updatedTasksList = [...state.taskList, TodoModel(id: uuid.v4(), content: content)];
    emit(TasksUpdate(updatedTasksList));
  }

  void toggleTask(String id) {
    final updatedTasksList = state.taskList.map((e) {
      if (e.id == id) {
        return e.copyWith(isChecked: !e.isChecked);
      }
      return e;
    }).toList();
    emit(TasksUpdate(updatedTasksList));
  }

  void removeTask(String id) {
    final updatedTasksList = state.taskList.where((e) => e.id != id).toList();
    emit(TasksUpdate(updatedTasksList));
  }
}
