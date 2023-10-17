import 'package:spedtracker_app/models/card_model.dart';

class CreditCard extends CardModel {
  DateTime fechaFacturacion;
  DateTime ultimoDiaPago;
  double tasaInteres;
  double lineaCredito;

  CreditCard(
    String cardId,
    String cardNum,
    String currency,
    DateTime expDate,
    String operadora,
    this.fechaFacturacion,
    this.ultimoDiaPago,
    this.tasaInteres,
    this.lineaCredito, {
    String cardHolder = '',
  }) {
    super.idTarjeta = cardId;
    super.numeroTarjeta = cardNum;
    super.moneda = currency;
    super.expDate = expDate;
    super.operadoraFinanciera = operadora;
    super.cardHolder = cardHolder;
  }
}
