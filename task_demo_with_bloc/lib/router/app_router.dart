
import 'package:flutter/material.dart';
import 'package:task_demo_with_bloc/screens/tabs_screen.dart';
import 'package:task_demo_with_bloc/screens/pending_tasks_screen.dart';

import '../screens/recycle_bin_screen.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case RecycleBinScreen.id:
        return MaterialPageRoute(builder: (context) => const RecycleBinScreen());
     case TabsScreen.id:
        return MaterialPageRoute(builder: (context) => TabsScreen());
      default:
        return null;
    }
  }
}