import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

/// Task Provider for state management using Provider package
class TaskProvider extends ChangeNotifier {
  static const String _tasksKey = 'tasks_list';
  late SharedPreferences _prefs;
  List<Task> _tasks = [];
  bool _isLoaded = false;

  List<Task> get tasks => _tasks;
  bool get isLoaded => _isLoaded;

  /// Initialize preferences and load tasks
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadTasks();
  }

  /// Load tasks from SharedPreferences
  Future<void> _loadTasks() async {
    try {
      final tasksJson = _prefs.getStringList(_tasksKey) ?? [];

      if (tasksJson.isEmpty) {
        // If no saved tasks, use default tasks
        _tasks = [
          Task(
            id: '1',
            title: 'Design the UI mockups',
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
          ),
          Task(
            id: '2',
            title: 'Review pull requests',
            isCompleted: true,
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
          ),
          Task(
            id: '3',
            title: 'Update documentation',
            createdAt: DateTime.now(),
          ),
        ];
        await _saveTasks();
      } else {
        _tasks = tasksJson.map((taskJson) {
          return Task.fromJson(jsonDecode(taskJson));
        }).toList();
      }
    } catch (e) {
      debugPrint('Error loading tasks: $e');
      _tasks = [];
    }
    _isLoaded = true;
    notifyListeners();
  }

  /// Save tasks to SharedPreferences
  Future<void> _saveTasks() async {
    try {
      final tasksJson = _tasks
          .map((task) => jsonEncode(task.toJson()))
          .toList();
      await _prefs.setStringList(_tasksKey, tasksJson);
    } catch (e) {
      debugPrint('Error saving tasks: $e');
    }
  }

  /// Add a new task
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
    );

    _tasks.insert(0, newTask);
    await _saveTasks();
    notifyListeners();
  }

  /// Toggle task completion status
  Future<void> toggleTaskCompletion(String taskId) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      await _saveTasks();
      notifyListeners();
    }
  }

  /// Delete a task
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    await _saveTasks();
    notifyListeners();
  }

  /// Get total tasks count
  int get totalTasksCount => _tasks.length;

  /// Get completed tasks count
  int get completedTasksCount =>
      _tasks.where((task) => task.isCompleted).length;

  /// Get pending tasks count
  int get pendingTasksCount => _tasks.where((task) => !task.isCompleted).length;
}
