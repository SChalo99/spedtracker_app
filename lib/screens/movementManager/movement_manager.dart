import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';

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
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              margin: const EdgeInsets.all(10),
              color: Colors.grey.shade400,
              child: const Center(
                child: Text(
                  'S/. XXXXXX',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              child: const Text(
                '+ Agregar Ingreso',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.grey),
              ),
              onTap: () {},
            ),
            GestureDetector(
              child: const Text(
                '+ Agregar Gasto',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.grey),
              ),
              onTap: () {},
            ),
            GestureDetector(
              child: const Text(
                '+ Modificar Movimiento',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.grey),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(),
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
