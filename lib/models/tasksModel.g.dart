// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasksModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksModelAdapter extends TypeAdapter<TasksModel> {
  @override
  final int typeId = 1;

  @override
  TasksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TasksModel(
      taskName: fields[0] as String,
      day: fields[1] as String,
      date: fields[2] as String,
      time: fields[3] as String,
      ischecked: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, TasksModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.ischecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
