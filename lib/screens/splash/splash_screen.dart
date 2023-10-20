//1//import 'package:flutter/material.dart';
//2//import 'package:flutter/scheduler.dart';
//3//import 'package:spedtracker_app/components/background/background.dart';
//4//import 'package:spedtracker_app/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    /*4
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
    4*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: [
        //3//const Background(),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Container(
              height: 200,
              width: 200,
              padding: const EdgeInsets.all(20),
              /*2
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: SchedulerBinding
                              .instance.platformDispatcher.platformBrightness ==
                          Brightness.light
                      ? const ColorScheme.light().background
                      : const Color.fromRGBO(116, 107, 85, 1)),
              2*/
              child: Image.asset(
                "assets/logo.jpeg",
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

