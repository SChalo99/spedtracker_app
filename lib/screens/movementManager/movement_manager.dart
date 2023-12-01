import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/components/movements/movement_dragable.dart';
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';
import 'package:spedtracker_app/models/gasto_model.dart';
// import 'package:spedtracker_app/models/gasto_model.dart';
// import 'package:spedtracker_app/models/ingreso_model.dart';
import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/models/user_model.dart';
import 'package:spedtracker_app/screens/movementManager/ingresos/income_form.dart';
import 'package:spedtracker_app/screens/movementManager/gastos/expenses_form.dart';
import 'package:spedtracker_app/screens/movementManager/edit_movement.dart';
// import 'package:spedtracker_app/services/card_service.dart';

import 'package:spedtracker_app/services/movement_service.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/services/user_service.dart';

class MovementScreen extends StatefulWidget {
  final String userToken;
  final CardModel? tarjeta;
  const MovementScreen(
      {super.key, required this.userToken, required this.tarjeta});

  @override
  State<MovementScreen> createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {

  CardModel? card;
  UserModel? user;

  DateTime selectedDate = DateTime.parse('${DateTime.now().year}-${DateTime.now().month}-01');

  var ingresos = 0.0;
  var credito = 0.0;
  double gastoTotal = 0.0;

  String simbolo = "";
  List<MovementModel> movementList = [];
  List<MovementModel> incomesList = [];
  List<MovementModel> expensesList = [];
  MovementService service = MovementService();
  bool loading = true;

  Future<List<MovementModel>> fetchIncomes() async {
    return await service.fetchAllIncomesByCard(widget.userToken, card);
  }

  Future<List<MovementModel>> fetchExpenses() async {
    return await service.fetchAllExpensesByCard(widget.userToken, card);
  }

  void obtenerParametros(CardModel? card) {
    if (card is DebitCard) {
      setState(() {
        ingresos = card.ingresoMinimo;
      });
    } else if (card is CreditCard) {
      setState(() {
        credito = card.lineaCredito;
      });
    }

    if (card?.moneda == 'SOLES') {
      simbolo = 'S/.';
    } else if (card?.moneda == 'DOLARES') {
      simbolo = r'$';
    }
  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    
    List<GastoModel> gastosFiltrados = await MovementService()
        .fetchAllExpensesByDate(widget.userToken, card, selectedDate);

    List<MovementModel> ingresos = await fetchIncomes();
    List<MovementModel> gastos = await fetchExpenses();
    user = await UserService().getUser(widget.userToken);

    setState(() {
      incomesList.addAll(ingresos);
      expensesList.addAll(gastos);
      movementList.addAll(incomesList);
      movementList.addAll(expensesList);
      loading = false;
    });

    for (int i = gastos.length - 1; i >= 0; i--) {
      gastoTotal += gastosFiltrados[i].monto;
    }
  }

  void edit(MovementModel movement) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMovementScreen(
          userToken: widget.userToken,
          movement: movement,
          card: card,
        ),
      ),
    );
    print("Edit card: ${movement.idMovimiento}");
  }

  void goExpenses(){
    if(gastoTotal > user!.montoLimite){
      showPopup();
    }else{
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExpensesFormScreen(
              userToken: widget.userToken, card: card)));
    }
  }

  void showPopup() {

  // Widget del popup
  AlertDialog alertDialog = AlertDialog(
    content: Text("¡Has alcanzo el monto límite de gastos en esta tarjeta! Proceda con cuidado", style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),),
    actions: [
      // Botón de aceptar
      TextButton(
        onPressed: () {
          // Continuar a la siguiente pantalla
          Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExpensesFormScreen(
              userToken: widget.userToken, card: card)));
        },
        child: Text("Aceptar"),
      ),
      // Botón de cancelar
    ],
  );

  // Mostrar el popup
  showDialog(context: context, builder: (context) => alertDialog);
}

  void delete(MovementModel movement) async {
    // if(card is DebitCard){
    //   if(movement is GastoModel){
    //     card.ingresoMinimo = card.ingresoMinimo + movement.monto;
    //   }else if(movement is IngresoModel){
    //     card.ingresoMinimo = card.ingresoMinimo - movement.monto;
    //   }
    // }else if(card is CreditCard){
    //   card.lineaCredito = card.lineaCredito + movement.monto;
    // }
    // await CardService().editCard(widget.userToken, card);
    await service.removeMovement(widget.userToken, movement);
    setState(() {
      movementList.clear();
      incomesList.clear();
      expensesList.clear();
    });
    await getData();
    print("Delete movement: ${movement.idMovimiento}");
  }

  void goTo(String id) {
    print("Go to movement: $id");
  }

  @override
  void initState() {
    super.initState();
    card = widget.tarjeta;
    obtenerParametros(card);
    Future.delayed(Duration.zero, () async {
      await getData();
    });
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
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: SchedulerBinding
                          .instance.platformDispatcher.platformBrightness ==
                      Brightness.light
                  ? const ColorScheme.light().background
                  : const Color.fromRGBO(116, 107, 85, 1)),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 100),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  color: const Color.fromARGB(255, 196, 198, 231),
                  child: Center(
                    child: Text(
                      '$simbolo${card is DebitCard ? ingresos : card is CreditCard ? credito : ''}',
                      style: const TextStyle(
                          fontSize: 50,
                          color: Color.fromARGB(255, 100, 76, 196)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (!card!.numeroTarjeta.endsWith("*"))
                  if (card is DebitCard)
                    Row(children: [
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: const Text('+ Agregar Ingreso',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IncomeFormScreen(
                                      userToken: widget.userToken,
                                      card: card)));
                        },
                      ),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                if (!card!.numeroTarjeta.endsWith("*"))
                  Row(children: [
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: const Text('+ Agregar Gasto',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        goExpenses();
                      },
                    ),
                  ]),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: DragableMovement(
                        movements: movementList,
                        edit: edit,
                        delete: delete,
                        goToCallback: goTo)),
              ]),
        ),
        if (loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ]),
    );
  }
}
