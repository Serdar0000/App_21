import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/todo_screen.dart';
import 'themes/app_theme.dart';
import 'providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final taskProvider = TaskProvider();
  await taskProvider.init();
  runApp(MainApp(taskProvider: taskProvider));
}

class MainApp extends StatefulWidget {
  final TaskProvider taskProvider;

  const MainApp({super.key, required this.taskProvider});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: widget.taskProvider)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Modern To-Do List',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: TodoListScreen(
          onThemeToggle: _toggleTheme,
          isDarkMode: _isDarkMode,
        ),
      ),
    );
  }
}
