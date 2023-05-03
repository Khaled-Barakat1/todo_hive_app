import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../components/add_task_sheet.dart';
import '../models/tasks_model.dart';
import 'empty_list.dart';
import 'my_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Box box = Hive.box<Tasks>('tasksBox');
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Tasks>('tasksBox').listenable(),
        builder: (context, value, child) =>
            box.isEmpty ? const EmptyList() : const MyList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: const AddTaskSheet(),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
