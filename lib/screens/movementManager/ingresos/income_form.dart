import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/components/cards/atoms/user_card.dart';
import 'package:spedtracker_app/models/card_model.dart';

class IncomeFormScreen extends StatefulWidget {
  final String userToken;
  final Card card;
  const IncomeFormScreen(
      {super.key, required this.userToken, required this.card});

  @override
  State<IncomeFormScreen> createState() => _IncomeFormScreenState();
}

class _IncomeFormScreenState extends State<IncomeFormScreen> {
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _razonController = TextEditingController();
  late CardModel _card;
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

  void getData(String email, String password) async {
    try {} catch (e) {
      if (context.mounted) {
        debugPrint(e.toString());
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
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: UserCard(
                        cardId: _card.idTarjeta,
                        cardNum: _card.numeroTarjeta,
                        cardHolder: _card.cardHolder,
                        expDate:
                            "${_card.expDate!.toString().split("-")[1]}/${_card.expDate!.year.toString().split("0")[1]}",
                        service: _card.operadoraFinanciera,
                        goTo: () {}),
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
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _montoController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Monto a Ingresar"),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingrese un monto.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: TextFormField(
                      controller: _razonController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Ingresar Razón"),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
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
