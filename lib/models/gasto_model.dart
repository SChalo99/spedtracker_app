import 'package:spedtracker_app/models/movement_model.dart';

class GastoModel extends MovementModel {
  String rubro = '';
  String negocio = '';
  int nroCuotas = 0;

  GastoModel(
      this.rubro, this.negocio, this.nroCuotas, DateTime hora, DateTime fecha) {
    super.hora = hora;
    super.fecha = fecha;
  }
}
