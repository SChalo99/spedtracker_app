import 'package:spedtracker_app/services/card_service.dart';

abstract class CardModel {
  String idTarjeta = '';
  String numeroTarjeta = '';
  String moneda = '';
  String type = '';
  String cardHolder = '';
  String expMonth = '';
  String expYear = '';
  String operadoraFinanciera = '';

  CardModel();

  Future<void> addCard(String token, CardModel cardModel) async {
    await CardService().createCard(token, cardModel);
  }

  Future<void> editCard(String token, CardModel cardModel) async {
    await CardService().editCard(token, cardModel);
  }

  Future<void> removeCard(String token, CardModel cardModel) async {
    await CardService().removeCard(token, cardModel);
  }

  Future<List<CardModel>> fetchCards(String token) async {
    return await CardService().fetchAll(token);
  }
}
