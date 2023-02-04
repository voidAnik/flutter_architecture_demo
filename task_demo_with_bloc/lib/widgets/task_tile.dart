import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_blocs/tasks_bloc.dart';
import '../blocs/task_blocs/tasks_event.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDelete(BuildContext context, Task task){
    debugPrint(task.toString());
    task.isDeleted! ? context.read<TasksBloc>().add(DeleteTask(task: task)):
        context.read<TasksBloc>().add(RemoveTask(task: task));
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title,
        style: TextStyle(decoration: task.isDone! ? TextDecoration.lineThrough : null),),
      trailing: Checkbox(
        onChanged: task.isDeleted == false ? (value){
          context.read<TasksBloc>().add(UpdateTask(task: task));
        }:null, value: task.isDone,
      ),
      onLongPress: (){
        _removeOrDelete(context, task);
      },
    );
  }
}