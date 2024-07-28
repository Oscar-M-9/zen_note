import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatNoteDate(DateTime? updatedAt, DateTime createdAt) {
  DateTime dateToFormat = updatedAt ?? createdAt;
  DateTime now = DateTime.now();

  String formattedDate;
  if (DateUtils.isSameDay(dateToFormat, now)) {
    // Si es la fecha actual, mostrar solo la hora
    formattedDate = DateFormat('hh:mm a').format(dateToFormat);
  } else if (now.difference(dateToFormat).inDays < 7 &&
      now.weekday >= dateToFormat.weekday) {
    // Si está dentro de la semana actual, mostrar el día de la semana y la hora
    formattedDate = DateFormat('EEE hh:mm a').format(dateToFormat);
  } else if (dateToFormat.year == now.year) {
    // Si es del mismo año, mostrar sin el año
    formattedDate = DateFormat('d MMMM').format(dateToFormat);
  } else {
    // Si es de un año diferente, mostrar la fecha completa con el año
    formattedDate = DateFormat('d MMMM yyyy').format(dateToFormat);
  }

  return formattedDate;
}

String formatDateTime(DateTime? updatedAt, DateTime createdAt) {
  DateTime dateToFormat = updatedAt ?? createdAt;
  DateTime now = DateTime.now();

  // Formatear la fecha según las condiciones especificadas
  String formattedDate;
  if (dateToFormat.year == now.year) {
    // Si es del mismo año, mostrar sin el año
    formattedDate = DateFormat('d \'de\' MMMM hh:mm a').format(dateToFormat);
  } else {
    // Si es de un año diferente, mostrar la fecha completa con el año
    formattedDate =
        DateFormat('d \'de\' MMMM \'de\' yyyy hh:mm a').format(dateToFormat);
  }

  return formattedDate;
}
