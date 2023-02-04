import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_demo_with_bloc/screens/my_drawer.dart';

import '../blocs/task_blocs/tasks_bloc.dart';
import '../blocs/task_blocs/tasks_state.dart';
import '../models/task.dart';
import '../widgets/add_task_screen.dart';
import '../widgets/task_list.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);

  static const String id = 'task_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.pendingTasks;
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Center(
                child: Chip(
                  label: Text(
                    '${taskList.length} Pending | ${state.completedTasks.length} Completed',
                  ),
                ),
              ),
              TaskList(taskList: taskList)
            ],
          );
      },
    );
  }
}


