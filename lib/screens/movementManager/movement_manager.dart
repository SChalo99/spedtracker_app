import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
//import 'package:spedtracker_app/components/cards/molecules/movement_list.dart';
import 'package:spedtracker_app/screens/movementManager/gastos/expenses_card_selector.dart';
import 'package:spedtracker_app/screens/movementManager/ingresos/income_card_selector.dart';
import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/services/movement_service.dart';

class MovementScreen extends StatefulWidget {
  final String userToken;
  const MovementScreen({super.key, required this.userToken});

  @override
  State<MovementScreen> createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {
  bool loading = true;

  List<MovementModel> movementList = [];
  List<MovementModel> incomesList = [];
  List<MovementModel> expensesList = [];

  MovementService service = MovementService();
  
  Future<List<MovementModel>> fetchIncomes() async {
    return await service.fetchAllIncomes(widget.userToken);
  }

  Future<List<MovementModel>> fetchExpenses() async {
    return await service.fetchAllExpenses(widget.userToken);
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditCardScreen(
    //       userToken: widget.userToken,
    //       card: card,
    //     ),
    //   ),
    // );
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
                  color: Colors.grey.shade400,
                  child: const Center(
                    child: Text(
                      'S/. XXXXXX',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Text(
                      '+ Agregar Ingreso',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.grey),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IncomeCardSelectorScreen(
                                  userToken: widget.userToken)));
                    },
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Text(
                      '+ Agregar Gasto',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.grey),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpensesCardSelectorScreen(
                                  userToken: widget.userToken)));
                    },
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Text(
                      '+ Modificar Movimiento',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.grey),
                    ),
                    onTap: () {},
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container()
                  // child: MovementList(
                  //   movements: movementList,
                  //   edit: edit,
                  //   delete: delete,
                  //   goToCallback: goTo
                  // ),
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
