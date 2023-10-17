import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/models/user_model.dart';
import 'package:spedtracker_app/screens/cardManager/card_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spedtracker_app/screens/login/password_recovery.dart';
import 'package:spedtracker_app/screens/login/signup_screen.dart';
import 'package:spedtracker_app/services/fcm_service.dart';
import 'package:spedtracker_app/services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  bool obscure = true;

  void onTap() {
    setState(() {
      obscure = !obscure;
    });
  }

  void login(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      String? token = await user.user?.getIdToken();
      String? fcmToken = await FCMService().getFCMToken();
      //UserModel myAccount = await UserService().getUser(token!);
      //myAccount.fcm = fcmToken;
      await UserService().updateFCMUser(token!, fcmToken!);

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CardScreen(userToken: token),
          ),
        );
      }
    } on FirebaseAuthException {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuario o contraseña incorrectos"),
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void goToRecoveryPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordRecoveryScreen(),
      ),
    );
  }

  void goToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                invertColors: SchedulerBinding
                        .instance.platformDispatcher.platformBrightness ==
                    Brightness.dark,
                image: const AssetImage("assets/background/original.png"),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      "Inicio de Sesión",
                      style: TextStyle(fontSize: 32),
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        obscureText: obscure,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: onTap,
                              icon: Icon(!obscure
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          border: const OutlineInputBorder(),
                          label: const Text("Contraseña"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su contraseña.';
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
                          login(_userController.text, _passwordController.text);
                        }
                      },
                      style: FilledButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromRGBO(28, 33, 22, 1)),
                      child: const Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        goToRecoveryPassword();
                      },
                      child: const Text("¿Olvidó su contraseña?"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        goToSignUp();
                      },
                      child: const Text("Regístrate"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
