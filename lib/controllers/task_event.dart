import 'package:equatable/equatable.dart';


sealed class TaskEvent extends Equatable {
  @override

  List<Object?> get props => [];
}


class TaskAddEvent extends TaskEvent {
  final String title;

  TaskAddEvent(this.title);

}

class TaskRemoveEvent extends TaskEvent {
  final String id;
  TaskRemoveEvent(this.id);
}

class TaskToggleEvent extends TaskEvent {
  final String id;
  TaskToggleEvent(this.id);
}