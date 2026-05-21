import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:state_management_bloc_cubit/controllers/task_event.dart';
import 'package:state_management_bloc_cubit/controllers/task_state.dart';
import 'package:state_management_bloc_cubit/models/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskAddEvent>(_addTask);
    on<TaskRemoveEvent>(_removeTask);
    on<TaskToggleEvent>(_toggleTask);
  }

  FutureOr<void> _addTask(TaskAddEvent event, Emitter<TaskState> emit) {
    final TaskModel task = TaskModel(
      id: Uuid().v4(),
      title: event.title,
      isCompleted: false,
    );
    emit(TaskUpdate([...state.taskList, task]));
  }

  FutureOr<void> _removeTask(TaskRemoveEvent event, Emitter<TaskState> emit) {
    final List<TaskModel> newList = state.taskList
        .where((task) => task.id != event.id)
        .toList();
    emit(TaskUpdate(newList));
  }

  FutureOr<void> _toggleTask(TaskToggleEvent event, Emitter<TaskState> emit) {
    final List<TaskModel> newList = state.taskList
        .map(
          (task) => task.id == event.id
              ? task.copyWith(isCompleted: !task.isCompleted)
              : task,
        )
        .toList();
    emit(TaskUpdate(newList));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskUpdate(
      (json["todos"] as List<dynamic>)
          .map((e) => TaskModel.fromMap(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return {"todos": state.taskList.map((t) => t.toMap()).toList()};
  }
}
