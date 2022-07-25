import 'package:appwrite/appwrite.dart';
import 'package:auth_system/data/service/appwrite_auth_service.dart';
import 'package:auth_system/main.dart';
import 'package:auth_system/view_pages/auth_pages/signup.dart';
import 'package:auth_system/widget/make_elevated_button.dart';
import 'package:auth_system/widget/make_text.dart';
import 'package:auth_system/widget/make_text_button.dart';
import 'package:auth_system/widget/make_text_field.dart';
import 'package:auth_system/widget/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = true;
  late TextEditingController _email;
  late TextEditingController _pass;

  late FocusNode femail;
  late FocusNode fpass;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _pass = TextEditingController();
    femail = FocusNode();
    fpass = FocusNode();
  }

  @override
  void dispose() {
    femail.dispose();
    fpass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.09,
              left: size.width * 0.02,
              right: size.width * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                makeText(
                  "Auth System",
                  fontWeight: FontWeight.bold,
                  size: Theme.of(context).textTheme.headline5!.fontSize,
                ),
                SizedBox(
                  height: size.height * 0.2,
                ),
                makeText(
                  "Log In",
                  fontWeight: FontWeight.bold,
                  textColor: Colors.grey,
                  size: Theme.of(context).textTheme.headline6!.fontSize,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                makeTextField(
                  autofocus: true,
                  controller: _email,
                  hintText: "Enter your Email",
                  obscureText: false,
                  focusNode: femail,
                  onFieldSubmitted: (next) {
                    femail.unfocus();
                    FocusScope.of(context).requestFocus(fpass);
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: size.height * 0.013,
                ),
                makeTextField(
                    autofocus: true,
                    controller: _pass,
                    hintText: "Enter your Password",
                    obscureText: _showPassword,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    focusNode: fpass,
                    textInputAction: TextInputAction.done),
                SizedBox(
                  height: size.height * 0.02,
                ),
                makeElevatedButton(
                  "Login",
                  textSize: Theme.of(context).textTheme.button!.fontSize!,
                  onPressed: () async {
                    var email = _email.text;
                    var pass = _pass.text;
                    try {
                      await AuthAppwrite.instance!.login(
                        email: email,
                        password: pass,
                      );

                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          content: makeText(
                            "Welcome to Auth System",
                          ),
                        ),
                      );
                      pushReplacement(context, const MainPage());
                    } on AppwriteException catch (e) {
                      if(kDebugMode) print(e.message);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          content: makeText(
                            e.message!,
                          ),
                        ),
                      );
                    }
                  },
                  minimumSize: Size(
                    size.width * 0.5,
                    size.height * 0.05,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    makeText("If you don't have an account?"),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    makeTextButton("Signup", onPressed: () {
                      push(context, const SignupPage());
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
