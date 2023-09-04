import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool? ischanged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              // checkColor: Colors.yellow,
              // activeColor: Colors.yellow,
              // shape: const CircleBorder(),
              value: ischanged,
              onChanged: (value) {
                setState(() {
                  ischanged = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
