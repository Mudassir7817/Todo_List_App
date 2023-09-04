import 'package:hive/hive.dart';

part 'tasksModel.g.dart';

@HiveType(typeId: 1)
class TasksModel {
  TasksModel({
    required this.taskName,
    required this.day,
    required this.date,
    required this.time,
    this.ischecked = false,
  });
  @HiveField(0)
  late final String taskName;
  @HiveField(1)
  late final String day;
  @HiveField(2)
  late final String date;
  @HiveField(3)
  late final String time;
  @HiveField(4)
  bool? ischecked;

  TasksModel.fromJson(Map<String, dynamic> json) {
    taskName = json['taskName'];
    day = json['day'];
    date = json['date'];
    time = json['time'];
    ischecked = json['ischecked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['taskName'] = taskName;
    _data['day'] = day;
    _data['date'] = date;
    _data['time'] = time;
    _data['ischecked'] = false;
    return _data;
  }
}
