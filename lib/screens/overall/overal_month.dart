import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/components/selector_chip/atom.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/models/categoria_model.dart';
import 'package:spedtracker_app/models/gasto_model.dart';
import 'package:spedtracker_app/services/category_service.dart';
import 'package:spedtracker_app/services/movement_service.dart';

class OverallMonthScreen extends StatefulWidget {
  final String userToken;
  final CardModel card;
  const OverallMonthScreen(
      {super.key, required this.userToken, required this.card});

  @override
  State<OverallMonthScreen> createState() => _OverallMonthScreenState();
}

class _OverallMonthScreenState extends State<OverallMonthScreen> {
  DateTime selectedDate = DateTime.now();
  late Set<String> filters = {};

  late Future<Map<String, double>> dataMap;
  Map dates = {
    'ENE': DateTime.parse('${DateTime.now().year}-01-01'),
    'FEB': DateTime.parse('${DateTime.now().year}-02-01'),
    'MAR': DateTime.parse('${DateTime.now().year}-03-01'),
    'ABR': DateTime.parse('${DateTime.now().year}-04-01'),
    'MAY': DateTime.parse('${DateTime.now().year}-05-01'),
    'JUN': DateTime.parse('${DateTime.now().year}-06-01'),
    'JUL': DateTime.parse('${DateTime.now().year}-07-01'),
    'AGO': DateTime.parse('${DateTime.now().year}-08-01'),
    'SET': DateTime.parse('${DateTime.now().year}-09-01'),
    'OCT': DateTime.parse('${DateTime.now().year}-10-01'),
    'NOV': DateTime.parse('${DateTime.now().year}-11-01'),
    'DIC': DateTime.parse('${DateTime.now().year}-12-01')
  };

  void toggleFilter(String month, bool selected) {
    setState(() {
      filters.clear();
      if (selected) {
        filters.add(month);
      } else {
        filters.remove(month);
      }
      selectedDate = dates[month];
      dataMap = Future<Map<String, double>>.delayed(
          Duration.zero, () async => await getData(selectedDate));
    });
  }

  Future<Map<String, double>> getCategories(List<GastoModel> movement) async {
    List<CategoriaModel> categories = await CategoryService().fetchCategories();
    Map<String, double> dataMap = {};
    for (CategoriaModel categoria in categories) {
      double total = 0.0;
      List<GastoModel> catMovement = movement
          .where((element) => element.idCategoria == categoria.idCategoria)
          .toList();
      debugPrint(catMovement.length.toString());
      for (GastoModel catMov in catMovement) {
        debugPrint(DateTime.july.toString());
        setState(() {
          debugPrint(catMov.monto.toString());
          total += catMov.monto;
        });
      }
      setState(() {
        dataMap.addAll({categoria.nombre: total});
      });
      debugPrint(dataMap.toString());
    }
    return dataMap;
  }

  Future<Map<String, double>> getData(DateTime date) async {
    List<GastoModel> movimientos = await MovementService()
        .fetchAllExpensesByDate(widget.userToken, widget.card, date);
    return await getCategories(movimientos);
  }

  @override
  void initState() {
    super.initState();
    dataMap = Future<Map<String, double>>.delayed(
        Duration.zero, () async => await getData(selectedDate));
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                MonthFilterSelector(
                  toggleFilterCallback: toggleFilter,
                  filters: filters,
                ),
                FutureBuilder(
                  future: dataMap,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        PieChart(
                          dataMap: snapshot.data as Map<String, double>,
                          chartValuesOptions: const ChartValuesOptions(
                              decimalPlaces: 2,
                              showChartValuesInPercentage: true),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ...snapshot.data!.entries.map((e) => Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.key),
                                Text('S/. ${e.value.toStringAsFixed(2)}')
                              ],
                            )),
                      ]);
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
