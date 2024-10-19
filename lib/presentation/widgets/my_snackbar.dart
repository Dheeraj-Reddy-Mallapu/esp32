import 'package:esp32/constants.dart';
import 'package:flutter/material.dart';

showSnackBar({required String message, double? durationInSec}) {
  rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(color: Colors.white)),
    duration: Duration(
        milliseconds:
            durationInSec != null ? (durationInSec * 1000).toInt() : 3000),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    closeIconColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
  ));
}
