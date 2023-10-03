import 'package:flutter/material.dart';
import 'package:spedtracker_app/components/cards/molecules/card_dragable.dart';
import 'package:spedtracker_app/models/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/screens/cardManager/add_card_screen.dart';

class CardScreen extends StatefulWidget {
  final String userToken;
  const CardScreen({super.key, required this.userToken});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  CardModel card1 = CardModel("1", "4111 1111 1111 1111", "CREDITO",
      "GONZALO GARMA GARCIA", "10", "26", "VISA");
  CardModel card2 = CardModel("2", "5111 1111 1111 1118", 'DEBITO',
      'GONZALO GARMA GARCIA', "11", "28", "MASTERCARD");
  CardModel card3 = CardModel("3", "3712 1212 1212 122", 'CREDITO EXTENSIÓN',
      'GONZALO GARMA GARCIA', "10", "26", "AMERICANEXPRESS");
  CardModel card4 = CardModel("3", "360012 1212 1210", 'CREDITO EXTENSIÓN',
      "GONZALO GARMA GARCIA", "10", "26", "DINNERSCLUB");

  CardModelList cards = CardModelList.instance;

  void edit(String id) {
    print("Edit card: $id");
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
    cards.addCard(card1);
    cards.addCard(card2);
    cards.addCard(card3);
    cards.addCard(card4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gestión de Tarjetas",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
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
          const SizedBox(
            height: 20,
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
    );
  }
}
