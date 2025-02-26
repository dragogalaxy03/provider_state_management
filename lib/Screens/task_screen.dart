import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Provider/taks_provider.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  String _selectedPriority = "Medium";
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text("To-Do List"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, size: 28),
        onPressed: () => _showAddTaskDialog(context, taskProvider),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: taskProvider.tasks.isEmpty
            ? Center(child: Text("No tasks yet! 🎉", style: TextStyle(fontSize: 18)))
            : ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            final task = taskProvider.tasks[index];
            return Dismissible(
              key: Key(task.title),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                color: Colors.redAccent,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    SizedBox(width: 8),
                    Text("Delete", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
              onDismissed: (direction) {
                taskProvider.removeTask(index);
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: task.isCompleted ? Colors.grey[300] : Colors.white,
                child: ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      taskProvider.toggleTask(index);
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      color: task.isCompleted ? Colors.grey[700] : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    "Priority: ${task.priority} | Due: ${DateFormat.yMMMd().format(task.dueDate)}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  trailing: task.isCompleted
                      ? IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      taskProvider.removeTask(index);
                    },
                  ) : Icon(
                    task.priority == "High"
                        ? Icons.priority_high  // 🔥 Show important for high-priority tasks
                        : Icons.schedule,      // ⏳ Show pending for others
                    color: task.priority == "High" ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Show Dialog for Adding Task
  void _showAddTaskDialog(BuildContext context, TaskProvider taskProvider) {
    String tempPriority = _selectedPriority;
    DateTime tempDate = _selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Add New Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _taskController,
                    decoration: InputDecoration(labelText: "Task Title"),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: tempPriority,
                    decoration: InputDecoration(
                      labelText: "Priority",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    dropdownColor: Colors.white,
                    items: ["High", "Medium", "Low"]
                        .map(
                          (priority) => DropdownMenuItem(
                        value: priority,
                        child: Row(
                          children: [
                            Icon(
                              Icons.flag,
                              color: priority == "High"
                                  ? Colors.red
                                  : priority == "Medium"
                                  ? Colors.orange
                                  : Colors.green,
                            ),
                            SizedBox(width: 10),
                            Text(
                              priority,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setDialogState(() => tempPriority = value!);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    icon: Icon(Icons.calendar_today),
                    label: Text("Pick Due Date"),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: tempDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setDialogState(() => tempDate = pickedDate);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      taskProvider.addTask(_taskController.text, tempPriority, tempDate);
                      _taskController.clear();
                      setState(() {
                        _selectedPriority = "Medium";
                        _selectedDate = DateTime.now();
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add Task"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
