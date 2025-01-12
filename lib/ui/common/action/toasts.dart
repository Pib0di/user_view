import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class AppToast {
  static void info(
    String message, {
    ToastGravity gravity = ToastGravity.TOP,
    bool returnStr = true,
  }) {
    Fluttertoast.cancel();
    return FToast().showToast(
      gravity: gravity,
      toastDuration: const Duration(seconds: 3),
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => FToast().removeQueuedCustomToasts(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent[100],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static void error(
    String message, {
    ToastGravity gravity = ToastGravity.TOP,
    bool returnStr = true,
  }) {
    Fluttertoast.cancel();
    return FToast().showToast(
      gravity: gravity,
      toastDuration: const Duration(seconds: 3),
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => FToast().removeQueuedCustomToasts(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
