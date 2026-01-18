import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/task_tile.dart';
import '../widgets/add_task_sheet.dart';
import '../providers/task_provider.dart';
import '../constants/app_colors.dart';

/// Main To-Do List Screen
class TodoListScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const TodoListScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen>
    with TickerProviderStateMixin {
  late AnimationController _floatingButtonController;

  @override
  void initState() {
    super.initState();
    _floatingButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _floatingButtonController.dispose();
    super.dispose();
  }

  void _showAddTaskBottomSheet() {
    _floatingButtonController.forward();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTaskSheet(
        onTaskAdded: (title) {
          context.read<TaskProvider>().addTask(title);
        },
      ),
    ).then((_) {
      _floatingButtonController.reverse();
    });
  }

  void _showSettingsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Settings',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('App Version'),
              subtitle: const Text('v0.1.0'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.format_list_bulleted_rounded),
              title: const Text('Total Tasks'),
              subtitle: Text(
                context.watch<TaskProvider>().totalTasksCount.toString(),
              ),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.check_circle_outline_rounded),
              title: const Text('Completed'),
              subtitle: Text(
                context.watch<TaskProvider>().completedTasksCount.toString(),
              ),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pending_actions_rounded),
              title: const Text('Pending'),
              subtitle: Text(
                context.watch<TaskProvider>().pendingTasksCount.toString(),
              ),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'My Tasks',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: _showSettingsMenu,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.settings_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              size: 24,
            ),
            tooltip: widget.isDarkMode ? 'Light Mode' : 'Dark Mode',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: taskProvider.tasks.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: taskProvider.tasks[index],
                  onToggle: () => context
                      .read<TaskProvider>()
                      .toggleTaskCompletion(taskProvider.tasks[index].id),
                  onDelete: () => context.read<TaskProvider>().deleteTask(
                    taskProvider.tasks[index].id,
                  ),
                  index: index,
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTaskBottomSheet,
        icon: const Icon(Icons.add_rounded, size: 28),
        label: const Text(
          'Add Task',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDarkMode
            ? AppColorsDark.primary
            : AppColorsLight.primary,
        foregroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No tasks yet',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first task to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _showAddTaskBottomSheet,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Create Task'),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
