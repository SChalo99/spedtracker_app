import 'package:spedtracker_app/models/card_model.dart';

class CardModelList {
  CardModelList._internal();
  static final CardModelList _instance = CardModelList._internal();
  List<CardModel> cardList = [];

  static CardModelList get instance {
    return _instance;
  }

  void addCard(CardModel value) {
    cardList.add(value);
  }

  void editCard(CardModel card) {
    cardList.removeWhere((item) => item.idTarjeta == card.idTarjeta);
    cardList.add(card);
  }

  void removeCard(String id) {
    cardList.removeWhere((item) => item.idTarjeta == id);
  }
}
