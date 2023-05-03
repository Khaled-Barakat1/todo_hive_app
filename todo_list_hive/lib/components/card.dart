import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/tasks_model.dart';
import 'update_task_sheet.dart';

class TasksCard extends StatefulWidget {
  TasksCard({super.key, this.task, this.index});
  int? index;
  Tasks? task;
  @override
  State<TasksCard> createState() => _TasksCardState();
}

class _TasksCardState extends State<TasksCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: UpdateTaskSheet(
                  task: widget.task,
                  index: widget.index,
                ),
              );
            });
      },
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              setState(() {
                Hive.box<Tasks>('tasksBox').deleteAt(widget.index!);
              });
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(15),
          )
        ]),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          child: ListTile(
            title: Text(
              '${widget.task!.title}',
              style: TextStyle(
                  decoration: widget.task!.isDone!
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationThickness: 2,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              '${widget.task!.desc}',
            ),
            leading: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                fillColor:
                    MaterialStatePropertyAll(Theme.of(context).primaryColor),
                shape: const CircleBorder(),
                value: widget.task!.isDone,
                onChanged: (bool? value) {
                  setState(() {
                    widget.task!.isDone = value!;
                    Hive.box<Tasks>('tasksBox')
                        .putAt(widget.index!, widget.task!);
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
