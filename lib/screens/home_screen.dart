import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/models/user_model.dart';
import 'package:spedtracker_app/screens/cardManager/card_screen.dart';
import 'package:spedtracker_app/screens/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userToken;
  const HomeScreen({super.key, required this.userToken});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserModel _model = UserModel.empty();
  UserModel? user = UserModel('Gonzalo', 'Garma', '12345678', '24',
      '20163126@aloe.ulima.edu.pe', 'Masculino', '51987654321');

  Future<UserModel> getUser(String token) async {
    return await _model.visualizar(token);
  }

  void logout() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut().whenComplete(() => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      //user = await getUser(widget.userToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: [
        const Background(),
        Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  "Bienvenid@ ${user!.nombre}!",
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 3 / 4,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(100)),
              color: SchedulerBinding
                          .instance.platformDispatcher.platformBrightness ==
                      Brightness.light
                  ? const ColorScheme.light().background
                  : const ColorScheme.dark().background),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/logo.jpeg"),
                  ),
                ),
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CardScreen(userToken: widget.userToken)));
                },
                style: FilledButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(28, 33, 22, 1)),
                child: const Text(
                  "Gestionar Tarjetas",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(
                onPressed: () {
                  logout();
                },
                style: FilledButton.styleFrom(
                    fixedSize: const Size(250, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 192, 15, 15)),
                child: const Text(
                  "Cerrar Sesión",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
