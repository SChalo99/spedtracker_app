import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';
import 'package:spedtracker_app/models/ingreso_model.dart';
import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/models/gasto_model.dart';
import 'package:spedtracker_app/services/card_service.dart';
import 'package:spedtracker_app/services/movement_service.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/screens/movementManager/movement_manager.dart';
import 'package:uuid/uuid.dart';

class EditMovementScreen extends StatefulWidget {
  final String userToken;
  final MovementModel? movement;
  final CardModel? card;
  const EditMovementScreen(
      {super.key, required this.userToken, required this.movement, required this.card});

  @override
  State<EditMovementScreen> createState() => _EditMovementScreenState();
}

class _EditMovementScreenState extends State<EditMovementScreen> {

  MovementModel? movement;
  CardModel? card;
  double? montoInicial = 0.0;
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _nroCuotasController = TextEditingController();
  final List razonOption = ["1", "2", "3"];
  final _formKey = GlobalKey<FormState>();
  var uuid = const Uuid();
  int idCategoria = 0;
  FocusNode focusNode = FocusNode();

  void editMovement(MovementModel? movement, CardModel? card) async {
    if(card is DebitCard){
      if(movement is GastoModel){
        card.ingresoMinimo = card.ingresoMinimo + (montoInicial!-double.parse(_montoController.text));
      }else if(movement is IngresoModel){
        card.ingresoMinimo = card.ingresoMinimo - (montoInicial!-double.parse(_montoController.text));
      }
    }else if(card is CreditCard){
      card.lineaCredito = card.lineaCredito + (montoInicial!-double.parse(_montoController.text));
    }
    setState(() {
      movement?.monto = double.parse(_montoController.text);
      movement?.descripcion = _descripcionController.text;
    });

    if (movement is GastoModel) {
      setState(() {
        movement.nroCuotas =  int.parse(_nroCuotasController.text);
        movement.idCategoria = idCategoria;
      });
    }

    await MovementService().editMovement(widget.userToken, movement);
    await CardService().editCard(widget.userToken, card);

    if (context.mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MovementScreen(userToken: widget.userToken, tarjeta: card)));
    }
  }

  void loadData(MovementModel movement) {

    setState(() {
      _montoController.text = movement.monto.toString();
      _descripcionController.text = movement.descripcion;
    });

    if (movement is GastoModel) {
      setState(() {
        _nroCuotasController.text =  movement.nroCuotas.toString();
        idCategoria = movement.idCategoria;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    movement = widget.movement;
    card = widget.card;
    montoInicial = movement?.monto;
    print(movement?.monto);
    print(card?.numeroTarjeta);
    loadData(movement!);
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
                    "Editar Movimiento",
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
                  if(movement is GastoModel)
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
                  if(movement is GastoModel)
                      const SizedBox(
                      height: 20,
                    ),
                    if(movement is GastoModel)
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
                        editMovement(movement, card);
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