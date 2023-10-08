import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spedtracker_app/components/alerts/products/abstract_alert.dart';

class IOSAlert implements AbstractAlert {
  @override
  Future showAlertDialog(
      BuildContext context, String title, String body, Function accept) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: const Text('Aceptar'),
            onPressed: () {
              accept.call();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
