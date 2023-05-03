import 'package:hive/hive.dart';
part 'tasks_model.g.dart';

@HiveType(typeId: 0)
class Tasks {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? desc;

  @HiveField(2)
  bool? isDone = false;

  Tasks({this.title, this.desc});
}
