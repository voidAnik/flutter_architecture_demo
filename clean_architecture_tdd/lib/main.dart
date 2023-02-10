import 'package:clean_architecture_tdd/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:clean_architecture_tdd/injection_container.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // dependency injection init
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Number Trivia',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.green.shade800,
          secondary: Colors.green.shade600
        )
      ),
      home: const NumberTriviaPage(),
    );
  }
}

