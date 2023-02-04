import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_demo_with_bloc/blocs/task_blocs/tasks_bloc.dart';
import 'package:task_demo_with_bloc/widgets/task_tile.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index){
          return TaskTile(task: taskList[index]);
        },
        itemCount: taskList.length,
      ),
    );
  }
}

