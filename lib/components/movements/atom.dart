import 'package:flutter/material.dart';
import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/models/ingreso_model.dart';

class MovementAtom extends StatelessWidget {
  final MovementModel movement;
  final int id;

  const MovementAtom({super.key, required this.movement, required this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(movement.descripcion),
        subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(movement.fecha.toString()),
              Text(
                  movement is IngresoModel
                      ? movement.monto.toString()
                      : '-${movement.monto}',
                  style: TextStyle(
                      color:
                          movement is IngresoModel ? Colors.green : Colors.red))
            ]),
      ),
    );
  }
}
