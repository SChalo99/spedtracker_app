import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/services/movement_service.dart';

class IngresoModel extends MovementModel {

  IngresoModel(String idMovimiento, double monto, String descripcion, DateTime hora, DateTime fecha) {
    super.idMovimiento = idMovimiento;
    super.monto = monto;
    super.descripcion = descripcion;
    super.hora = hora;
    super.fecha = fecha;
  }

  @override
  Future<List<MovementModel>> fetchMovements(String token) async {
    return await MovementService().fetchAllIncomes(token);
  }
  
}
