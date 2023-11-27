import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/models/gasto_model.dart';
import 'package:spedtracker_app/services/movement_service.dart';
import 'package:spedtracker_app/screens/movementManager/movement_manager.dart';
import 'package:uuid/uuid.dart';

class ExpensesFormScreen extends StatefulWidget {
  final String userToken;
  final String card;
  const ExpensesFormScreen(
      {super.key, required this.userToken, required this.card});

  @override
  State<ExpensesFormScreen> createState() => _ExpensesFormScreenState();
}

class _ExpensesFormScreenState extends State<ExpensesFormScreen> {
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _nroCuotasController = TextEditingController();
  final List razonOption = ["1", "2", "3"];
  final _formKey = GlobalKey<FormState>();
  var uuid = const Uuid();
  int idCategoria = 0;
  FocusNode focusNode = FocusNode();

  void createExpense() async {
    //DateTime now = DateTime.now();
    DateTime fechaMovimiento = DateTime.now();
    DateTime horaMovimiento = DateTime.now();
    String idMovimiento = uuid.v4();

    MovementModel nuevoMovimiento;
    nuevoMovimiento = GastoModel(
      idCategoria,
      int.parse(_nroCuotasController.text),
      idMovimiento,
      double.parse(_montoController.text),
      _descripcionController.text,
      horaMovimiento,
      fechaMovimiento);

    debugPrint(nuevoMovimiento.fecha.toString());
    debugPrint(nuevoMovimiento.hora.toString());

    await MovementService().createMovement(widget.userToken, nuevoMovimiento);

    if (context.mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MovementScreen(userToken: widget.userToken)));
    }
  }

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
                      controller: _descripcionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Ingresar Descripción"),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: DropdownMenu<String>(
                      width: 300,
                      menuStyle: const MenuStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      label: const Text("Ingresar Categoría"),
                      enableSearch: false,
                      onSelected: (value) {
                        setState(() {
                          idCategoria = int.parse(value!);
                        });
                      },
                      dropdownMenuEntries: razonOption.map((e) {
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
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _nroCuotasController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Ingresar Número de Cuotas"),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingrese un número de cuotas.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        createExpense();
                        print("Gasto registrado");
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
