import 'package:spedtracker_app/services/movement_service.dart';

abstract class MovementModel {

  String idMovimiento = '';
  double monto = 0.0;
  String descripcion = '';
  DateTime hora = DateTime.now();
  DateTime fecha = DateTime.now();

  MovementModel();

  Future<void> addMovement(String token, MovementModel movementModel) async {
    await MovementService().createMovement(token, movementModel);
  }

  Future<void> editMovement(String token, MovementModel movementModel) async {
    await MovementService().editMovement(token, movementModel);
  }

  Future<void> removeMovement(String token, MovementModel movementModel) async {
    await MovementService().removeMovement(token, movementModel);
  }

  Future<List<MovementModel>> fetchMovements(String token);
}
