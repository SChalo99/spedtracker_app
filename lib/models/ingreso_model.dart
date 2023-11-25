import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/services/movement_service.dart';

class IngresoModel extends MovementModel {
  double monto = 0.0;

  IngresoModel(this.monto, String idMovimiento, DateTime hora, DateTime fecha) {
    super.idMovimiento = idMovimiento;
    super.hora = hora;
    super.fecha = fecha;
  }

  @override
  Future<List<MovementModel>> fetchMovements(String token) async {
    return await MovementService().fetchAllIncomes(token);
  }
  
}
