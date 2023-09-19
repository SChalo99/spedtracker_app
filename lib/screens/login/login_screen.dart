import 'package:flutter/material.dart';
import 'package:spedtracker_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  void onTap() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: AssetImage("assets/backgorund.png"),
            // ),
            ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
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
                      return 'Please enter a valid email.';
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
                      return 'Please enter a password.';
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
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
                onTap: () {},
                child: const Text("¿Olvidó su contraseña?"),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: const Text("Regístrate"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
