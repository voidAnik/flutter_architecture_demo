

import 'package:equatable/equatable.dart';

import '../../models/task.dart';

class TasksState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> removedTasks;
  final List<Task> completedTasks;
  final List<Task> favouriteTasks;
  const TasksState({
    this.pendingTasks = const <Task>[],
    this.removedTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.favouriteTasks = const <Task>[],
  });

  @override
  List<Object> get props => [pendingTasks, removedTasks, completedTasks, favouriteTasks];

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'favouriteTasks': favouriteTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTasks: List<Task>.from(map['pendingTasks'].map((x) => Task.fromMap(x))),
      removedTasks: List<Task>.from(map['removedTasks'].map((x) => Task.fromMap(x))),
      completedTasks: List<Task>.from(map['completedTasks'].map((x) => Task.fromMap(x))),
      favouriteTasks: List<Task>.from(map['favouriteTasks'].map((x) => Task.fromMap(x))),
    );
  }
}
