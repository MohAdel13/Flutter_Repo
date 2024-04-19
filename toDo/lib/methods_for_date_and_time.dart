import 'package:flutter/material.dart';

Future<DateTime?> dateOnTap(BuildContext context)async{
  return await showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime.parse('2025-04-15'),
    initialDate: DateTime.now(),
  );
}

Future<TimeOfDay?> timeOnTap(BuildContext context)async {
  return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
  );
}