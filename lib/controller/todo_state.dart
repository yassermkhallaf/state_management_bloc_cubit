part of 'todo_bloc.dart';

@immutable
sealed class TodoState extends Equatable {
  List<TodoModel> todoList;

  TodoState(this.todoList);

  @override
  // TODO: implement props
  List<Object?> get props => [todoList];
}

class TodoInitial extends TodoState {
  TodoInitial() : super([]);
}

class TodoUpdate extends TodoState {
  TodoUpdate(super.todoList);
}
