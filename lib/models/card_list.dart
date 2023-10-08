import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';

class CardModelList {
  CardModelList._internal();
  static final CardModelList _instance = CardModelList._internal();
  List<CardModel> cardList = [];

  static CardModelList get instance {
    if (_instance.cardList.isEmpty) {
      CardModel card1 = DebitCard("1", "4111 1111 1111 1111", 'SOLES', "DEBITO",
          "GONZALO GARMA GARCIA", "10", "26", "VISA", '');
      CardModel card2 = DebitCard("2", "5111 1111 1111 1118", 'SOLES', 'DEBITO',
          'GONZALO GARMA GARCIA', "11", "28", "MASTERCARD", '');
      CardModel card3 = DebitCard("3", "3712 1212 1212 122", 'SOLES', 'DEBITO',
          'GONZALO GARMA GARCIA', "10", "26", "AMERICANEXPRESS", '');
      CardModel card4 = DebitCard("4", "360012 1212 1210", 'CREDITO EXTENSIÓN',
          "GONZALO GARMA GARCIA", "DINNERSCLUB", "10", "26", '', '');
      _instance.addCard(card1);
      _instance.addCard(card2);
      _instance.addCard(card3);
      _instance.addCard(card4);
    }
    return _instance;
  }

  void addCard(CardModel value) {
    cardList.add(value);
  }

  void editCard(CardModel card) {
    cardList.removeWhere((item) => item.cardId == card.cardId);
    cardList.add(card);
  }

  void removeCard(String id) {
    cardList.removeWhere((item) => item.cardId == id);
  }
}
