import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spedtracker_app/components/cards/molecules/card_dragable.dart';
import 'package:spedtracker_app/models/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/screens/cardManager/add_card_screen.dart';
import 'package:spedtracker_app/screens/cardManager/edit_card_screen.dart';
import 'package:spedtracker_app/screens/login/login_screen.dart';

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

  void logout() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut().whenComplete(() => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false));
  }

  @override
  void initState() {
    super.initState();
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
        actions: [
          TextButton(
            onPressed: () {
              logout();
            },
            child: const Text(
              "Cerrar Cesión",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
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
