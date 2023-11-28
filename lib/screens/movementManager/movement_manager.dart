import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/components/movements/movement_dragable.dart';
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';
import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/screens/movementManager/ingresos/income_form.dart';
import 'package:spedtracker_app/screens/movementManager/gastos/expenses_form.dart';
import 'package:spedtracker_app/screens/movementManager/edit_movement.dart';
import 'package:spedtracker_app/services/movement_service.dart';
import 'package:spedtracker_app/models/card_model.dart';

class MovementScreen extends StatefulWidget {
  final String userToken;
  final CardModel? tarjeta;
  const MovementScreen({super.key, required this.userToken, required this.tarjeta});

  @override
  State<MovementScreen> createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {

  CardModel? card;
  var ingresos = 0.0;
  var credito = 0.0;
  List<MovementModel> movementList = [];
  List<MovementModel> incomesList = [];
  List<MovementModel> expensesList = [];
  MovementService service = MovementService();
  bool loading = true;

  Future<List<MovementModel>> fetchIncomes() async {
    return await service.fetchAllIncomes(widget.userToken);
  }

  Future<List<MovementModel>> fetchExpenses() async {
    return await service.fetchAllExpenses(widget.userToken);
  }
  
  // Future<List<MovementModel>> fetchIncomes() async {
  //   return await service.fetchAllIncomesByCard(widget.userToken, card);
  // }

  // Future<List<MovementModel>> fetchExpenses() async {
  //   return await service.fetchAllExpensesByCard(widget.userToken, card);
  // }

  void obtenerParametros(CardModel? card){
    if (card is DebitCard) {
      setState(() {
        ingresos = card.ingresoMinimo;
      });
    }else if(card is CreditCard){
      setState(() {
        credito = card.lineaCredito;
      });
    }
  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    List<MovementModel> ingresos = await fetchIncomes();
    List<MovementModel> gastos = await fetchExpenses();

    

    setState(() {
      incomesList.addAll(ingresos);
      expensesList.addAll(gastos);
      movementList.addAll(incomesList);
      movementList.addAll(expensesList);
      loading = false;
    });
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

  void delete(MovementModel movement) async {
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
    print(card?.numeroTarjeta);
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
                  color: Color.fromARGB(45, 38, 46, 132),
                  child: Center(
                    child: Text(
                      '${card is DebitCard? ingresos : card is CreditCard? credito : ''}',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                if(card is DebitCard)
                  Row(children: [
                    
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      
                      child: const Text(
                        '+ Agregar Ingreso',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                            
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IncomeFormScreen(
                                    userToken: widget.userToken, card: card)));
                      },
                    ),
                  ]),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: const Text(
                      '+ Agregar Gasto',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpensesFormScreen(
                                  userToken: widget.userToken, card: card,)));
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
                    goToCallback: goTo
                    )
                ),
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
