import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/components/cards/molecules/card_dragable.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/screens/cardManager/add_card_screen.dart';
import 'package:spedtracker_app/screens/cardManager/edit_card_screen.dart';
import 'package:spedtracker_app/services/card_service.dart';


class CardScreen extends StatefulWidget {
  final String userToken;
  const CardScreen({super.key, required this.userToken});

  @override
  State<CardScreen> createState() => _CardScreenState();
}


class _CardScreenState extends State<CardScreen> {
  /*3
  List<CardModel> cardList = [];
  List<CardModel> debitCardList = [];
  List<CardModel> creditCardList = [];
  CardService service = CardService();
  bool loading = true;
  
  Future<List<CardModel>> fetchCreditCard() async {
    return await service.fetchAllCredit(widget.userToken);
  }

  Future<List<CardModel>> fetchDebitCard() async {
    return await service.fetchAllDebit(widget.userToken);
  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    List<CardModel> debits = await fetchDebitCard();
    List<CardModel> credits = await fetchCreditCard();
    setState(() {
      debitCardList.addAll(debits);
      creditCardList.addAll(credits);
      cardList.addAll(debitCardList);
      cardList.addAll(creditCardList);
      loading = false;
    });
  }
  3*/
  /*4
  void edit(CardModel card) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCardScreen(
          userToken: widget.userToken,
          card: card,
        ),
      ),
    );
    print("Edit card: ${card.idTarjeta}");
  }

  void delete(CardModel card) async {
    await service.removeCard(widget.userToken, card);
    setState(() {
      cardList.clear();
      creditCardList.clear();
      debitCardList.clear();
    });
    await getData();
    print("Delete card: ${card.idTarjeta}");
  }

  void goTo(String id) {
    print("Go to card: $id");
  }

  void addCard() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddCardScreen(userToken: widget.userToken)));
  }
  4*/
  /*3
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getData();
    });
  }
  3*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: [
        /*5
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
        5*/
        Container(
          /*5
          decoration: BoxDecoration(
              color: SchedulerBinding
                          .instance.platformDispatcher.platformBrightness ==
                      Brightness.light
                  ? const ColorScheme.light().background
                  : const Color.fromRGBO(116, 107, 85, 1)),
          5*/
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 100),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: () {
                addCard();
              },
              style: FilledButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(28, 33, 22, 1)),
              child: const Text(
                "Agregar Tarjeta",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: DragableCard(
                  cards: cardList,
                  edit: edit,
                  delete: delete,
                  goToCallback: goTo),
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

