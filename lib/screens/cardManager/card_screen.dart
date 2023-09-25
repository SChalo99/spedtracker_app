import 'package:flutter/material.dart';
import 'package:spedtracker_app/components/cards/user_card.dart';
import 'package:spedtracker_app/models/card_model.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  CardModel card1 = CardModel("1234 5678 9123 4567", 'CREDITO',
      'GONZALO GARMA GARCIA', "10", "26", "VISA");
  CardModel card2 = CardModel("1762 0938 3829 2374", 'DEBITO',
      'GONZALO GARMA GARCIA', "11", "28", "MASTERCARD");
  CardModel card3 = CardModel("9837 3928 2839 2030", 'CREDITO EXTENSIÓN',
      'GONZALO GARMA GARCIA', "10", "26", "VISA");

  List<CardModel> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list.addAll([card1, card2, card3]);
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                CardModel e = list[index];
                return ListTile(
                  subtitle: UserCard(
                      cardNum: e.cardNum,
                      type: e.type,
                      cardHolder: e.cardHolder,
                      expMonth: e.expMonth,
                      expYear: e.expYear,
                      service: e.service),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
