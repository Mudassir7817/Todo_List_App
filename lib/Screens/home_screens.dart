import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_list_app/Colors/Colors.dart';
import 'package:todo_list_app/Screens/BottomSheet.dart';
import 'package:todo_list_app/Screens/Completed_Tasks.dart';

import '../Helpers/today-tomorrow-day.dart';
import '../models/tasksModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Helper helper = Helper();
  List<TasksModel> searchlist = [];
  bool _isSearching = false;
  Box<TasksModel> taskbox = Hive.box<TasksModel>('todo');
  Box<TasksModel> completedTaskbox = Hive.box<TasksModel>('completedtask');
  TextEditingController texteditingsearchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Coolors.bodycolor,
            appBar: AppBar(
              elevation: 0.5,
              title: _isSearching
                  ? SizedBox(
                      height: 50,
                      width: 310,
                      child: TextFormField(
                        onChanged: (query) {
                          _performSearch(query);
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Colors.black,
                          fillColor: Color.fromARGB(255, 226, 226, 226),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 14),
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(28)),
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      'Task Flow',
                      style: TextStyle(fontSize: 26),
                    ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                      if (!_isSearching) {
                        texteditingsearchcontroller.clear();
                        searchlist.clear();
                      }
                    });
                  },
                ),
                PopupMenuButton(
                    onSelected: (click) {
                      switch (click) {
                        case 0:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CompletedTasks()));
                          break;
                        case 1:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CompletedTasks()));
                          break;
                        case 2:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CompletedTasks()));
                          break;
                        case 3:
                          Share.share('https://DummyUrlofTaskFlow');
                          break;
                        default:
                      }
                    },
                    color: Coolors.appbarcolor,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: newItem("Completed Tasks"),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: newItem("Contact Us"),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: newItem("Help"),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: newItem("Share with friends"),
                          ),
                          PopupMenuItem(
                            value: 4,
                            child: newItem("Settings"),
                          ),
                        ],
                    child: _isSearching
                        ? null
                        : const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.more_vert),
                          )),
              ],
            ),
            body: ValueListenableBuilder(
              valueListenable: taskbox.listenable(),
              builder: (context, Box box, widget) {
                if (taskbox.isEmpty) {
                  return const Center(
                      child: Text(
                    'Add A Task',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ));
                } else {
                  return ListView.builder(
                    itemCount:
                        _isSearching ? searchlist.length : taskbox.length,
                    itemBuilder: (context, index) {
                      TasksModel? task = _isSearching
                          ? searchlist[index]
                          : taskbox.getAt(index);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            Helper.findTaskDay(DateTime(2023, 9, 29)),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Card(
                            shadowColor:
                                const Color.fromARGB(255, 195, 223, 236),
                            margin: const EdgeInsets.all(8.0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            color: Coolors.cardcolor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // for showing task
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 16.0),
                                        child: Text(
                                          task!.taskName,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
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
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          // for showing date
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              ' ${task.date}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              ' ${task.day}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                Checkbox(
                                  tristate: false,
                                  shape: const CircleBorder(),
                                  value: task.ischecked,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      task.ischecked = newValue;
                                    });

                                    if (newValue == true) {
                                      Future.delayed(const Duration(seconds: 1),
                                          () async {
                                        setState(() {
                                          box.deleteAt(index);
                                          completedTaskbox.add(task);
                                        });

                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Task Completed'),
                                          ),
                                        );
                                      });
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showBottomSheet();
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        searchlist.clear();
      });
      return;
    }

    final List<TasksModel> matchingTasks = taskbox.values.where((task) {
      return task.taskName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchlist = matchingTasks;
    });
  }

  newItem(String text) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Coolors.cardcolor,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return const ShowCustomBottomSheet();
        });
  }
}
