import 'package:flutter/material.dart';

abstract class AbstractAlert {
  Future showAlertDialog(
      BuildContext context, String title, String body, Function accept);
}
