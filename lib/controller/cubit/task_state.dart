part of 'task_cubit.dart';

@immutable
sealed class TaskState extends Equatable {
  final List<TodoModel> taskList;

  const TaskState(this.taskList);

  @override
  // TODO: implement props
  List<Object?> get props => [taskList];
}

final class TasksInitial extends TaskState {
  TasksInitial() : super([]);
}

final class TasksUpdate extends TaskState {
  const TasksUpdate(super.taskList);
}
