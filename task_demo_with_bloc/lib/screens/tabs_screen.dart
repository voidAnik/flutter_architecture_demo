
import 'package:flutter/material.dart';
import 'package:task_demo_with_bloc/screens/completed_tasks_screen.dart';
import 'package:task_demo_with_bloc/screens/favourite_tasks_screen.dart';
import 'package:task_demo_with_bloc/screens/my_drawer.dart';
import 'package:task_demo_with_bloc/screens/pending_tasks_screen.dart';

import '../widgets/add_task_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {
      'pageName': const PendingTasksScreen(),
      'title': 'Pending Tasks'
    },
    {
      'pageName': const CompletedTasksScreen(),
      'title': 'Completed Tasks'
    },
    {
      'pageName': const FavouriteTasksScreen(),
      'title': 'Favourite Tasks'
    },
  ];

  var _selectedPageIndex = 0;

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
    debugPrint("build");
    return Scaffold(
      appBar: AppBar(
        title: Text('${_pageDetails[_selectedPageIndex]['title']}'),
        actions: [
          IconButton(
            onPressed: () {
              _addTask(context);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0 ? FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ):null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index){
          debugPrint('on tap');
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle),
            label: 'Pending Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Completed Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite Tasks'
          ),

        ],
      ),
    );
  }
}
