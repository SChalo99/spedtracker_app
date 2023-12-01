import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/models/user_model.dart';
import 'package:spedtracker_app/screens/home_screen.dart';
import 'package:spedtracker_app/services/user_service.dart';

class LimitScreen extends StatefulWidget {
  final String userToken;
  const LimitScreen(
      {super.key, required this.userToken});

  @override
  State<LimitScreen> createState() => _LimitScreenState();
}

class _LimitScreenState extends State<LimitScreen> {

  final TextEditingController _montoLimiteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

  void defineLimit() async {

    UserModel user = await UserService().getUser(widget.userToken);

    user.montoLimite = double.parse(_montoLimiteController.text);

    await UserService().editUser(widget.userToken, user);

    if (context.mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(userToken: widget.userToken)));
    }
  }


  @override
  void initState() {
    super.initState();
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
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(100)),
              color: SchedulerBinding
                          .instance.platformDispatcher.platformBrightness ==
                      Brightness.light
                  ? const ColorScheme.light().background
                  : const Color.fromRGBO(116, 107, 85, 1)),
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
                  const Text(
                    "Límite de Gastos",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _montoLimiteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Ingresar monto límite"),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        defineLimit();
                      }
                    },
                    style: FilledButton.styleFrom(
                        fixedSize: const Size(250, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(28, 33, 22, 1)),
                    child: const Text(
                      "Guardar",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}