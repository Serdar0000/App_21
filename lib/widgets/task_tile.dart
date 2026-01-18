import 'package:flutter/material.dart';
import '../models/task_model.dart';

/// Task Card Widget with animations
class TaskTile extends StatefulWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final int index;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.index,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(50, 0), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOut,
            ),
          ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  /// Checkbox
                  GestureDetector(
                    onTap: widget.onToggle,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.task.isCompleted
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.5),
                          width: 2,
                        ),
                        color: widget.task.isCompleted
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                      ),
                      child: widget.task.isCompleted
                          ? Icon(
                              Icons.check_rounded,
                              size: 16,
                              color: isDarkMode ? Colors.white : Colors.white,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),

                  /// Task Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                decoration: widget.task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: widget.task.isCompleted
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withOpacity(0.5)
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Created ${_formatDate(widget.task.createdAt)}',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  /// Delete Icon
                  IconButton(
                    onPressed: () {
                      _animationController.reverse().then((_) {
                        widget.onDelete();
                      });
                    },
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.6),
                      size: 20,
                    ),
                    splashRadius: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
