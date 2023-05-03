import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/tasks_model.dart';
import 'constunts.dart';

class UpdateTaskSheet extends StatefulWidget {
  UpdateTaskSheet({super.key, required this.task, required this.index});
  int? index;
  Tasks? task;
  TextEditingController? titleController = TextEditingController();
  TextEditingController? descController = TextEditingController();

  @override
  State<UpdateTaskSheet> createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskSheet> {
  @override
  Widget build(BuildContext context) {
    widget.titleController!.text = widget.task!.title!;
    widget.descController!.text = widget.task!.desc!;
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
                  'Update Task',
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
                    controller: widget.titleController,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: 'task title',
                    ),
                  ),
                   Text(
                    'Description',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 3,
                    maxLength: 200,
                    keyboardType: TextInputType.multiline,
                    controller: widget.descController,
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
                            widget.task!.title = widget.titleController!.text;
                            widget.task!.desc = widget.descController!.text;
                            Hive.box<Tasks>('tasksBox')
                                .putAt(widget.index!, widget.task!);
                          });
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: const Text(
                          'Update',
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
