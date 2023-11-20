import 'package:spedtracker_app/models/movement_model.dart';

class IngresoModel extends MovementModel {
  double monto = 0.0;

  IngresoModel(this.monto, DateTime hora, DateTime fecha) {
    super.hora = hora;
    super.fecha = fecha;
  }
}
