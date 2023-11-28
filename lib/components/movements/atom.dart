import 'package:flutter/material.dart';
import 'package:spedtracker_app/models/movement_model.dart';
import 'package:spedtracker_app/models/ingreso_model.dart';
import 'package:spedtracker_app/models/gasto_model.dart';

class MovementAtom extends StatelessWidget {
  final List<MovementModel> movements;
  final int id;

  const MovementAtom({
    super.key,
    required this.movements,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          MovementModel movement = movements[id];
          String monto = '';
          if(movement is GastoModel){
            monto = '-${movement.monto}';
          }else{
            monto = '+${movement.monto}';
          }
          return Card(
            child: ListTile(
              title: Text(movement.descripcion),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(movement.fecha.toString()),
                    Text(monto, style: TextStyle(color: movement is IngresoModel ? Colors.green : Colors.red))
                  ]),
            ),
          );
        });
  }
}
