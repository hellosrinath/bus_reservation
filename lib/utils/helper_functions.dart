import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormatedDate(DateTime dt, {String pattern = 'dd/MM/yyyy'}) {
  return DateFormat(pattern).format(dt);
}

void showMessage(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
        ),
      ),
    );
