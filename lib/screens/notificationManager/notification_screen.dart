import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/components/notifications/atoms.dart';

class MovementScreen extends StatefulWidget {
  final String userToken;
  const MovementScreen({super.key, required this.userToken});

  @override
  State<MovementScreen> createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {
  bool loading = true;

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                ),
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: SchedulerBinding
                          .instance.platformDispatcher.platformBrightness ==
                      Brightness.light
                  ? const ColorScheme.light().background
                  : const Color.fromRGBO(116, 107, 85, 1)),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 100),
          child: const Column(mainAxisSize: MainAxisSize.max, children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Notificaciones',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: NotificationAtom(
                notifications: [],
              ),
            ),
          ]),
        ),
        if (loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ]),
    );
  }
}
