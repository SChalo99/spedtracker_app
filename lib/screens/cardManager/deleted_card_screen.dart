import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/components/cards/molecules/card_dragable.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/services/card_service.dart';

class DeletedCardScreen extends StatefulWidget {
  final String userToken;
  const DeletedCardScreen({super.key, required this.userToken});

  @override
  State<DeletedCardScreen> createState() => _DeletedCardScreenState();
}

class _DeletedCardScreenState extends State<DeletedCardScreen> {
  List<CardModel> cardList = [];
  List<CardModel> debitCardList = [];
  List<CardModel> creditCardList = [];
  CardService service = CardService();
  bool loading = true;

  Future<List<CardModel>> fetchCreditCardDeleted() async {
    return await service.fetchAllCredit(widget.userToken);
  }

  Future<List<CardModel>> fetchDebitCardDeleted() async {
    return await service.fetchAllDebit(widget.userToken);
  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    List<CardModel> debits = await fetchDebitCardDeleted();
    List<CardModel> credits = await fetchCreditCardDeleted();
    setState(() {
      debitCardList.addAll(debits);
      creditCardList.addAll(credits);
      cardList.addAll(debitCardList);
      cardList.addAll(creditCardList);
      loading = false;
    });
  }

  void goTo(String id) {
    print("Go to card: $id");
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
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: DragableCard(
                  cards: cardList,
                  edit: () {},
                  delete: () {},
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
