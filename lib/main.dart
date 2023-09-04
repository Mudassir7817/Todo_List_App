import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list_app/Screens/splash_screen.dart';

import 'Colors/Colors.dart';
import 'models/tasksModel.dart';

late Size mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // Register the adapter
  Hive.registerAdapter(TasksModelAdapter());
  // open a box that will store tasks
  await Hive.openBox<TasksModel>('todo');
  await Hive.openBox<TasksModel>('completedtask');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Coolors.appbarcolor),
      ),
      home: const SplashScreen(),
    );
  }
}
