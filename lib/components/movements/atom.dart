import 'package:flutter/material.dart';
import 'package:spedtracker_app/models/movement_model.dart';

class MovementAtom extends StatelessWidget {
  final List<MovementModel> movements;

  const MovementAtom({
    super.key,
    required this.movements,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: movements.length,
        itemBuilder: (context, index) {
          MovementModel movement = movements[index];
          return Card(
            child: ListTile(
              title: Text(movement.descripcion),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(movement.fecha.toString()),
                    Text('${movement.monto}')
                  ]),
            ),
          );
        });
  }
}
