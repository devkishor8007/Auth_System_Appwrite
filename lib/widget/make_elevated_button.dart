import 'package:auth_system/widget/make_text.dart';
import 'package:flutter/material.dart';

Widget makeElevatedButton(
  String textString, {
  required Function onPressed,
  Size? minimumSize,
  double? textSize,
}) {
  return ElevatedButton(
    onPressed: () => onPressed,
    style: ElevatedButton.styleFrom(
      primary: Colors.amberAccent,
      onPrimary: Colors.black,
      minimumSize: minimumSize,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19),
      ),
    ),
    child: makeText(
      textString,
      size: textSize,
    ),
  );
}
