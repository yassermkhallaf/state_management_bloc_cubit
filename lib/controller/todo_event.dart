part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class TodoAdding extends TodoEvent {
  final TodoModel todo;

  TodoAdding(this.todo);
}

class TodoRemoving extends TodoEvent {
  final String id;

  TodoRemoving(this.id);
}

class TodoToggle extends TodoEvent {
  final String id;

  TodoToggle(this.id);
}



