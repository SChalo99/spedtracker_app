import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/models/ingreso_model.dart';
import 'package:spedtracker_app/services/movement_service.dart';
import 'package:spedtracker_app/screens/movementManager/movement_manager.dart';
import 'package:uuid/uuid.dart';

class IncomeFormScreen extends StatefulWidget {
  final String userToken;
  final String card;
  const IncomeFormScreen(
      {super.key, required this.userToken, required this.card});

  @override
  State<IncomeFormScreen> createState() => _IncomeFormScreenState();
}

class _IncomeFormScreenState extends State<IncomeFormScreen> {

  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var uuid = const Uuid();
  FocusNode focusNode = FocusNode();

  void createIncome() async {
    //DateTime now = DateTime.now();
    DateTime fechaMovimiento = DateTime.now();
    DateTime horaMovimiento = DateTime.now();
    String idMovimiento = uuid.v4();

    MovementModel nuevoMovimiento;
    nuevoMovimiento = IngresoModel(
      double.parse(_montoController.text),
      _descripcionController.text,
      idMovimiento,
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
                        label: Text("Ingresar descripción"),
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
                      if (_formKey.currentState!.validate()) {
                        createIncome();
                        print("Ingreso registrado");
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
