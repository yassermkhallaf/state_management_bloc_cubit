import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sate_management_bloc_cubit/models/todo_model.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoAdding>(_addTodo);
    on<TodoToggle>(_toggleTodo);
    on<TodoRemoving>(_removeTodo);
  }

  FutureOr<void> _addTodo(TodoAdding event, Emitter<TodoState> emit) {
    final TodoModel todo = event.todo;
    print(todo.id);
    final List<TodoModel> updatedList = [...state.todoList, todo];
    emit(TodoUpdate(updatedList));
  }

  FutureOr<void> _toggleTodo(TodoToggle event, Emitter<TodoState> emit) {
    final List<TodoModel> updatedList = state.todoList.map((e) {
      if (e.id == event.id) {
        return e.copyWith(isChecked: !e.isChecked);
      }
      return e;
    }).toList();
    emit(TodoUpdate(updatedList));
  }

  FutureOr<void> _removeTodo(TodoRemoving event, Emitter<TodoState> emit) {
    final List<TodoModel> updatedList = state.todoList.where((e) => e.id != event.id).toList();
    emit(TodoUpdate(updatedList));
  }
}
