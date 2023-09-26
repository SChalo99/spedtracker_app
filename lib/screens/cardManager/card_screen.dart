import 'package:flutter/material.dart';
import 'package:spedtracker_app/components/cards/user_card.dart';
import 'package:spedtracker_app/models/card_model.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  CardModel card1 = CardModel("1", "1234 5678 9123 4567", 'CREDITO',
      'GONZALO GARMA GARCIA', "10", "26", "VISA");
  CardModel card2 = CardModel("2", "1762 0938 3829 2374", 'DEBITO',
      'GONZALO GARMA GARCIA', "11", "28", "AMERICANEXPRESS");
  CardModel card3 = CardModel("3", "9837 3928 2839 2030", 'CREDITO EXTENSIÓN',
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
          const SizedBox(
            height: 20,
          ),
          FilledButton(
            onPressed: () {},
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                CardModel e = list[index];
                return Dismissible(
                  key: Key(e.cardId),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      list.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${e.cardNum} dismissed")));
                  },
                  background: Container(
                      color: Colors.red,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 60,
                          ),
                        ],
                      )),
                  child: ListTile(
                    subtitle: UserCard(
                        cardNum: e.cardNum,
                        type: e.type,
                        cardHolder: e.cardHolder,
                        expMonth: e.expMonth,
                        expYear: e.expYear,
                        service: e.service),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
