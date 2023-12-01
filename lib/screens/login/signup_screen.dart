import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/models/user_model.dart';
import 'package:spedtracker_app/models/user_singleton.dart';
//import 'package:spedtracker_app/screens/cardManager/card_screen.dart';
import 'package:spedtracker_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:spedtracker_app/services/fcm_service.dart';
import 'package:spedtracker_app/services/user_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final currentUser = UserSingleton.instance;
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final List genderOptions = [
    'Masculino',
    'Femenino',
    'Otros',
  ];
  String gender = "";
  String phoneNumber = "";
  double montoLimite = 0;
  FocusNode focusNode = FocusNode();
  bool obscure = true;
  bool obscure2 = true;

  void onTap() {
    setState(() {
      obscure = !obscure;
    });
  }

  void onTap2() {
    setState(() {
      obscure2 = !obscure2;
    });
  }

  void signup(String email, String password) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? token = await user.user?.getIdToken();
      String? fcmToken = await FCMService().getFCMToken();

      UserModel newUser = UserModel(
        _nameController.text,
        _lastNameController.text,
        _dniController.text,
        _ageController.text,
        email,
        gender,
        phoneNumber,
        montoLimite,
        idUsuario: user.user!.uid,
        fcm: fcmToken!,
      );
      await UserService().createUser(newUser);
      currentUser.currentUser = newUser;

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(userToken: token!),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Este usuario ya existe."),
            ),
          );
        }
      }
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
          height: MediaQuery.of(context).size.height * 3 / 4,
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
                    "Registro",
                    style: TextStyle(fontSize: 32),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 170,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Nombre"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su nombre.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 170,
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Apellido"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su apellido.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 240,
                        child: DropdownMenu<String>(
                          width: 240,
                          menuStyle: const MenuStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          label: const Text("Género"),
                          enableSearch: false,
                          onSelected: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                          dropdownMenuEntries: genderOptions.map((e) {
                            return DropdownMenuEntry<String>(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                              ),
                              value: e,
                              label: e,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 100,
                        height: 60,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Edad"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su apellido.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: IntlPhoneField(
                      controller: _phoneController,
                      validator: (value) {
                        final validPhoneNumber = RegExp(r'^[+0-9]*[0-9]*$');
                        if (value!.number.isEmpty ||
                            !validPhoneNumber.hasMatch(value.number)) {
                          return 'Ingrese un número válido';
                        }
                        return null;
                      },
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: "Número telefónico",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'PE',
                      languageCode: WidgetsBinding
                          .instance.platformDispatcher.locale.languageCode,
                      onChanged: (phone) {
                        //print(phone.completeNumber);
                        setState(() {
                          phoneNumber = phone.completeNumber.split('+').last;
                        });
                        debugPrint(phoneNumber);
                      },
                      onCountryChanged: (country) {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      maxLength: 8,
                      controller: _dniController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("DNI"),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingrese su DNI.';
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
                      controller: _emailController,
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
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: obscure2,
                      controller: _passwordConfirmationController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: onTap2,
                            icon: Icon(!obscure2
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        border: const OutlineInputBorder(),
                        label: const Text("Repetir Contraseña"),
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
                        if (_passwordController.text ==
                            _passwordConfirmationController.text) {
                          signup(
                              _emailController.text, _passwordController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Contraseñas no coinciden."),
                            ),
                          );
                        }
                      }
                    },
                    style: FilledButton.styleFrom(
                        fixedSize: const Size(250, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(28, 33, 22, 1)),
                    child: const Text(
                      "Crear Cuenta",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
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
