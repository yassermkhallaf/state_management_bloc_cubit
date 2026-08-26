import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String content;
   bool isChecked;

   TodoModel({required this.id, required this.content, this.isChecked = false});
  @override
  // TODO: implement props
  List<Object?> get props => [id, content, isChecked];

  TodoModel copyWith({
    String? id,
    String? content,
    bool? isChecked,
  }) {
    return TodoModel(
      id: id ?? this.id,
      content: content ?? this.content,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
