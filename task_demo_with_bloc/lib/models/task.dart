import 'package:equatable/equatable.dart';

import '../utils/id_generator.dart';

class Task extends Equatable{
  final String title;
  String? id;
  bool? isDone;
  bool? isDeleted;

   Task({required this.title, this.isDone, this.isDeleted, this.id}){
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    id = id ?? GUIDGen.generate();
  }

  Task copyWith({
    String? title,
    String? id,
    bool? isDone,
    bool? isDeleted,

  }) {
    return Task(
      title: title ?? this.title,
      id: id?? this.id,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      id: map['id'] as String,
      isDone: map['isDone'] as bool,
      isDeleted: map['isDeleted'] as bool,
    );
  }

  @override
  List<Object?> get props => [title, id, isDeleted, isDone];

  @override
  String toString() {
    return 'Task{title: $title, id: $id, isDone: $isDone, isDeleted: $isDeleted}';
  }
}