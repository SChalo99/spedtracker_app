import 'package:flutter/material.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/components/cards/molecules/card_dragable.dart';
import 'package:spedtracker_app/models/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/screens/cardManager/add_card_screen.dart';
import 'package:spedtracker_app/screens/cardManager/edit_card_screen.dart';

class CardScreen extends StatefulWidget {
  final String userToken;
  const CardScreen({super.key, required this.userToken});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  CardModelList cards = CardModelList.instance;

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

  void delete(String id) {
    setState(() {
      cards.removeCard(id);
    });

    print("Delete card: $id");
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
          color: Colors.white,
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
                  cards: cards.cardList,
                  edit: edit,
                  delete: delete,
                  goToCallback: goTo),
            ),
          ]),
        ),
      ]),
    );
  }
}
