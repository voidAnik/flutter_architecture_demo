
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Messenger {
  static showToast({
    required String message,
    BuildContext? context,
    Toast? toastLength,
    IconData? icon,
    double? fontSize,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
    Duration fadeDuration = const Duration(milliseconds: 350),
    Duration toastDuration = const Duration(seconds: 2),
    PositionedToastBuilder? positionedToastBuilder,
  }) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor ?? Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon ?? Icons.flutter_dash),
          const SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );

    if (context == null) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: toastLength,
          fontSize: fontSize,
          gravity: gravity,
          backgroundColor: Colors.black,
          textColor: textColor);
    } else {
      FToast fToast = FToast();
      fToast.init(context);
      fToast.showToast(
          child: toast,
          gravity: gravity,
          fadeDuration: fadeDuration,
          toastDuration: toastDuration,
          positionedToastBuilder: positionedToastBuilder);
    }


    /** Example to call
     *
     * Messenger.showToast(message: "Clicked button",
        context: context,
        icon: Icons.abc,
        backgroundColor: Colors.red,
        positionedToastBuilder: (context, child) {
        return Positioned(
        top: 16.0,
        left: 16.0,
        child: child,
        );
        }
        );
     */
  }

  static void flushBarError(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      messageText: Text(
        message,
        textAlign: TextAlign.start,
      ),
      forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      messageColor: Colors.black,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      reverseAnimationCurve: Curves.easeInOut,
      icon: const Icon(
        Icons.error,
        size: 28,
        color: Colors.white,
      ),
    )..show(context)
    );

  }
}
