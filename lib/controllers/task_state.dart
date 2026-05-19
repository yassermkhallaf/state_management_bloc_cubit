import"package:equatable/equatable.dart";
import "package:state_management_bloc_cubit/models/task_model.dart";
sealed class TaskState extends Equatable {
  final List<TaskModel> taskList;
  TaskState(this.taskList);
  @override

  List<Object?> get props => [taskList];
}

 class TaskInitial extends TaskState {
  TaskInitial():super([]);

}
class TaskUpdate extends TaskState{
  TaskUpdate(super.taskList);

}

