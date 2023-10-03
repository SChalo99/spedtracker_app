import 'package:spedtracker_app/models/card_model.dart';

class CardModelList {
  CardModelList._internal();
  static final CardModelList _instance = CardModelList._internal();
  List<CardModel> cardList = [];

  static CardModelList get instance => _instance;

  void addCard(CardModel value) {
    cardList.add(value);
  }

  void removeCard(String id) {
    cardList.removeWhere((item) => item.cardId == id);
  }
}
