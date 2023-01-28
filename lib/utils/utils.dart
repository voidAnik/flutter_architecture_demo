import 'package:flutter/cupertino.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context,
      FocusNode currentNode,
      FocusNode nextNode){

    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }
}