import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../Colors/Colors.dart';
import '../models/tasksModel.dart';

// ignore: must_be_immutable
class CompletedTasks extends StatefulWidget {
  const CompletedTasks({
    Key? key,
  }) : super(key: key);

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  Box completedtaskbox = Hive.box<TasksModel>('completedtask');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coolors.bodycolor,
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: ValueListenableBuilder(
        valueListenable: completedtaskbox.listenable(),
        builder: (context, Box box, child) {
          if (completedtaskbox.isEmpty) {
            return const Center(
                child: Text(
              'No Completed Tasks',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.white),
            ));
          } else {
            return ListView.builder(
              itemCount: completedtaskbox.length,
              itemBuilder: (context, index) {
                TasksModel task = completedtaskbox.getAt(index);
                return Flexible(
                  child: Card(
                    shadowColor: const Color.fromARGB(255, 195, 223, 236),
                    margin: const EdgeInsets.all(8.0),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    color: Coolors.cardcolor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // for showing task
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 16.0),
                                child: Text(
                                  task.taskName,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              // for showing day
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 4.0),
                                    child: Text(
                                      task.time,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                  // for showing date
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      ', ${task.date}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      ', ${task.day}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            color: Colors.red,
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              completedtaskbox.deleteAt(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
