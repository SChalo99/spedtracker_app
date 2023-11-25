import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/components/cards/molecules/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/screens/movementManager/ingresos/income_form.dart';
import 'package:spedtracker_app/services/card_service.dart';

class IncomeCardSelectorScreen extends StatefulWidget {
  final String userToken;
  const IncomeCardSelectorScreen({super.key, required this.userToken});

  @override
  State<IncomeCardSelectorScreen> createState() =>
      _IncomeCardSelectorScreenState();
}

class _IncomeCardSelectorScreenState extends State<IncomeCardSelectorScreen> {
  List<CardModel> debitCardList = [];
  CardService service = CardService();
  bool loading = true;

  Future<List<CardModel>> fetchDebitCard() async {
    return await service.fetchAllDebit(widget.userToken);
  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    List<CardModel> debits = await fetchDebitCard();
    setState(() {
      debitCardList.addAll(debits);
      loading = false;
    });
  }

  void goTo(String cardId) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                IncomeFormScreen(userToken: widget.userToken, card: cardId)));
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
                onPressed: () => Navigator.of(context).pop(),
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
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListCard(cards: debitCardList, goToCallback: goTo),
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
