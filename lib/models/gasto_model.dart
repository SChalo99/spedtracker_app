import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/services/movement_service.dart';


class GastoModel extends MovementModel {
  int idCategoria;
  double monto = 0.0;
  String descripcion = '';
  int nroCuotas = 0;

  GastoModel(
      this.idCategoria, this.monto, this.descripcion, this.nroCuotas, String idMovimiento, DateTime hora, DateTime fecha) {
    super.idMovimiento = idMovimiento;
    super.hora = hora;
    super.fecha = fecha;
  }

  @override
  Future<List<MovementModel>> fetchMovements(String token) async {
    return await MovementService().fetchAllExpenses(token);
  }

}
