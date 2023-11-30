import 'package:flutter/material.dart';
import 'package:spedtracker_app/components/alerts/alert_config.dart';
import 'package:spedtracker_app/components/movements/atom.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spedtracker_app/models/movement_model.dart';

class DragableMovement extends StatelessWidget {
  final List<MovementModel> movements;
  final Function edit;
  final Function delete;
  final Function goToCallback;
  final AlertConfig config = AlertConfig.instance;

  DragableMovement({
    super.key,
    required this.movements,
    required this.edit,
    required this.delete,
    required this.goToCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: movements.length,
        itemBuilder: (context, index) {
          MovementModel movement = movements[index];
          return Slidable(
            startActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    onPressed: (context) {
                      edit(movement);
                    },
                    backgroundColor: const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Editar',
                  ),
                ]),
            child: MovementAtom(movement: movement, id: index),
          );
        });
  }
}
