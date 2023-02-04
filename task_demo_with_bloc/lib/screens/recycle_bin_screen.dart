import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_blocs/tasks_bloc.dart';
import '../blocs/task_blocs/tasks_state.dart';
import '../models/task.dart';
import '../widgets/add_task_screen.dart';
import '../widgets/task_list.dart';
import 'my_drawer.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({Key? key}) : super(key: key);
  static const String id = 'recycle_bin_screen';

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const AddTaskScreen(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        debugPrint("drawer listen: $state");
        List<Task> taskList = state.removedTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    'Tasks: ${taskList.length}',
                  ),
                ),
              ),
               TaskList(taskList: taskList)
            ],
          ),
        );
      },
    );
  }
}
