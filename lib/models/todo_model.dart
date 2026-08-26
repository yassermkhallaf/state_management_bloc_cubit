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

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'content': this.content,
      'isChecked': this.isChecked,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      content: map['content'] as String,
      isChecked: map['isChecked'] as bool,
    );
  }

}
