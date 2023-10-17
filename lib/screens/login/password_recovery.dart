import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final TextEditingController _userController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool obscure = true;

  void onTap() {
    setState(() {
      obscure = !obscure;
    });
  }

  void recoverPassword(String email) async {
    try {
      auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Correo no encontrado"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Container(
              clipBehavior: Clip.antiAlias,
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
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
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
                        height: 20,
                      ),
                      const Text(
                        "Recuperar contraseña",
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 32),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _userController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Correo"),
                          ),
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (value.isEmpty || !emailValid) {
                              return 'Por favor, ingrese un correo válido.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            recoverPassword(_userController.text);
                          }
                        },
                        style: FilledButton.styleFrom(
                            fixedSize: const Size(250, 50),
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromRGBO(28, 33, 22, 1)),
                        child: const Text(
                          "Recuperar Contraseña",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
