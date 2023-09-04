import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../Colors/Colors.dart';
import '../models/tasksModel.dart';

class ShowCustomBottomSheet extends StatefulWidget {
  const ShowCustomBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowCustomBottomSheet> createState() => _ShowCustomBottomSheetState();
}

class _ShowCustomBottomSheetState extends State<ShowCustomBottomSheet> {
  SpeechToText speechtotext = SpeechToText();

  final _formkey = GlobalKey<FormState>();
  bool islistening = false;
  final _taskcontroller = TextEditingController();
  final _daycontroller = TextEditingController();
  final _datecontroller = TextEditingController();
  final _timecontroller = TextEditingController();
  Box taskbox = Hive.box<TasksModel>('todo');
  late String _taskName, _day, _time, _date;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: ListView(shrinkWrap: true, children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                'Add A new Task',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                showCursor: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please Enter Name';
                  } else {
                    return null;
                  }
                },
                controller: _taskcontroller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.add_task_sharp),
                  hintText: 'Task Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTapDown: (details) async {
                  if (!islistening) {
                    var available = await speechtotext.initialize();
                    if (available) {
                      setState(() {
                        islistening = true;
                        speechtotext.listen(
                          onResult: (result) {
                            _taskcontroller.text = result.recognizedWords;
                          },
                        );
                      });
                    }
                  }
                },
                onTapUp: (details) {
                  setState(() {
                    islistening = false;
                  });
                  speechtotext.stop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  radius: 25,
                  child: Icon(Icons.mic, color: Colors.white),
                )),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: _showCalendar,
                child: TextField(
                  enabled: false,
                  controller: _datecontroller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.date_range_rounded),
                      hintText: 'Due Date And Day',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: _showTime,
                child: TextField(
                  enabled: false,
                  controller: _timecontroller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.timer),
                      hintText: 'Time',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14)))),
                    backgroundColor:
                        MaterialStateProperty.all(Coolors.bodycolor),
                    fixedSize: MaterialStateProperty.all(const Size(200, 30))),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      _taskName = _taskcontroller.text;
                      _date = _datecontroller.text;
                      _day = _daycontroller.text;
                      _time = _timecontroller.text;
                      TasksModel newtask = TasksModel(
                          taskName: _taskName,
                          day: _day,
                          date: _date,
                          time: _time);
                      taskbox.add(newtask);
                    });

                    _taskcontroller.clear();
                    _datecontroller.clear();
                    _timecontroller.clear();
                    _daycontroller.clear();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  void _showCalendar() async {
    DateTime? selecteddate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (selecteddate != null) {
      setState(() {
        _datecontroller.text = DateFormat('dd-MMM').format(selecteddate);
        _date = _datecontroller.text;
        _daycontroller.text = DateFormat('EEE').format(selecteddate);
        _day = _daycontroller.text;
      });
    }
  }

  void _showTime() async {
    TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timeOfDay != null) {
      setState(() {
        _timecontroller.text = timeOfDay.format(context);
        _time = timeOfDay.format(context);
      });
    }
  }
}
