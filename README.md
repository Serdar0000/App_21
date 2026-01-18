# Modern To-Do List App 📝

A beautiful, feature-rich Flutter To-Do List application with dark mode support, persistent local storage, and state management using Provider.

## Features ✨

- ✅ **Add, Complete, and Delete Tasks** - Manage your tasks easily
- 🌙 **Dark Mode Support** - Toggle between light and dark themes
- 💾 **Persistent Storage** - Tasks saved locally using SharedPreferences
- 📊 **Task Statistics** - View total, completed, and pending tasks
- ⚙️ **Settings Menu** - Access app info and task statistics
- 🎨 **Modern UI Design** - Beautiful and responsive interface
- 🏗️ **State Management** - Provider pattern for clean architecture
- 🎯 **Animation Effects** - Smooth animations for all interactions

## Project Structure 📁

```
lib/
├── constants/
│   └── app_colors.dart              # Color palette for light & dark themes
├── models/
│   └── task_model.dart              # Task data model with JSON serialization
├── providers/
│   └── task_provider.dart           # State management for tasks (Provider)
├── screens/
│   └── todo_screen.dart             # Main to-do list screen
├── themes/
│   └── app_theme.dart               # Light and dark theme configuration
├── widgets/
│   ├── add_task_sheet.dart          # Bottom sheet for adding new tasks
│   └── task_tile.dart               # Individual task card widget
├── main.dart                        # App entry point
└── pubspec.yaml                     # Flutter dependencies
```

## Technologies Used 🛠️

- **Flutter** - UI framework
- **Dart** - Programming language
- **Provider** - State management
- **SharedPreferences** - Local data persistence
- **Material Design 3** - Modern UI design

## Getting Started 🚀

### Prerequisites
- Flutter SDK (^3.9.2)
- Dart SDK (included with Flutter)
- Git

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/Serdar0000/App_21.git
cd App_21
```

2. **Get dependencies:**
```bash
flutter pub get
```

3. **Run the app:**
```bash
flutter run
```

## Usage 📖

### Adding a Task
1. Tap the **"Add Task"** button (bottom-right FAB)
2. Enter task description
3. Tap **"Add Task"** to save

### Completing a Task
- Tap the **circle checkbox** next to any task to mark it as complete
- Completed tasks show a checkmark and strikethrough text

### Deleting a Task
- Tap the **delete icon** (trash can) on the right side of the task

### Theme Switching
- Tap the **moon/sun icon** in the app bar to toggle between light and dark themes

### Settings
- Tap the **settings icon** (gear) in the top-left to view:
  - App version
  - Total tasks count
  - Completed tasks count
  - Pending tasks count

## Features in Detail 🎯

### Persistent Storage
- Tasks are automatically saved to device storage using SharedPreferences
- All changes (add, edit, delete) persist even after app restart
- First-time users see 3 sample tasks

### State Management
- Uses **Provider** package for clean state management
- Centralized task management in `TaskProvider`
- Automatic UI updates on state changes

### Theming System
- Separate color palettes for light and dark modes
- `AppColorsLight` and `AppColorsDark` classes for easy customization
- Theme-aware components that automatically adapt

### Animations
- Floating Action Button with elastic scale animation
- Task list items with fade and slide animations
- Smooth bottom sheet transitions
- Theme transitions

## Dependencies 📦

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  shared_preferences: ^2.2.0
```

## App Information 📱

- **Name:** Modern To-Do List
- **Version:** 0.1.0
- **Supported Platforms:** Android, iOS, Web, Linux, macOS, Windows
- **Minimum Dart Version:** 3.9.2

## Future Enhancements 🔮

- [ ] Task categories/tags
- [ ] Due dates and reminders
- [ ] Task search and filter
- [ ] Cloud synchronization
- [ ] Task priority levels
- [ ] Recurring tasks
- [ ] Notes/descriptions for tasks
- [ ] Multiple lists/projects

## License 📜

This project is licensed under the MIT License.

## Author ✍️

Created as a Flutter learning project

---

**Made with ❤️ using Flutter**
