import 'package:auth_system/widget/make_text.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: makeText("Loading...."),
      ),
    );
  }
}
