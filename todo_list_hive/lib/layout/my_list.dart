import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../components/card.dart';
import '../models/tasks_model.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: Hive.box<Tasks>('tasksBox').listenable(),
        builder: (context, value, child) => Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            margin: EdgeInsets.only(top: size.height * 0.1),
            height: size.height,
            width: size.width,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        'To do',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          '${value.values.where((element) => element.isDone!).length} of ${value.values.length} tasks',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        backgroundColor: Colors.black12,
                        value: value.values
                                .where((element) => element.isDone!)
                                .length /
                            value.values.length,
                      )
                    ]),
              ),
              Row(
                children: [
                  Container(
                    width: 135,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      onPressed: () {
                        Box box = Hive.box<Tasks>('tasksBox');
                        for (int i = 0; i <= box.values.length; i++) {
                          Tasks task = Hive.box<Tasks>('tasksBox').getAt(i)!;
                          task.isDone = false;
                          box.putAt(i, task);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.fiber_manual_record,
                            color: Colors.white,
                          ),
                          Text(
                            'Un Do All',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return TasksCard(
                        task: value.getAt(index),
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: value.values.length,
                  )),
            ])));
  }
}
