import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/tasks_model.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final Box _box = Hive.box<Tasks>('tasksBox');
  TextEditingController? titleController = TextEditingController();
  TextEditingController? descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 15),
                child: const Text(
                  'Add Task',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                )),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Title',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLength: 20,
                    controller: titleController,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: 'task title',
                    ),
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 3,
                    maxLength: 200,
                    keyboardType: TextInputType.multiline,
                    controller: descController,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: 'task description',
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        
                        onPressed: () {
                          setState(() {
                            _box.add(Tasks(
                              title: titleController!.text,
                              desc: descController!.text,
                            ));
                            titleController = TextEditingController();
                            descController = TextEditingController();
                          });
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 20),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
