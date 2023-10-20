import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/services/card_service.dart';


class DebitCard extends CardModel {
  String accountNum;
  double ingresoMinimo;

  DebitCard(
    String cardId,
    String cardNum,
    String currency,
    DateTime expDate,
    String operadora,
    this.accountNum,
    this.ingresoMinimo, {
    String cardHolder = '',
  }) {
    super.idTarjeta = cardId;
    super.numeroTarjeta = cardNum;
    super.moneda = currency;
    super.expDate = expDate;
    super.operadoraFinanciera = operadora;
    super.cardHolder = cardHolder;
  }
  /*2
  @override
  Future<List<CardModel>> fetchCards(String token) async {
    return await CardService().fetchAllDebit(token);
  }
  2*/
}
1*/
