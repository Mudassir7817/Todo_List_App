import 'package:flutter/material.dart';

import '../main.dart';
import 'home_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 290,
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  "assets/images/Todo app icon.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 160,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset("assets/images/Todo app icon.png")),
                const Text(
                  ' Task Flow',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
