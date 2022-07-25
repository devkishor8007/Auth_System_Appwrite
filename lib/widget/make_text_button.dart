import 'package:auth_system/widget/make_text.dart';
import 'package:flutter/material.dart';

Widget makeTextButton(
  String textString, {
  required Function onPressed,
}) {
  return TextButton(onPressed: () => onPressed, child: makeText(textString));
}
