import 'package:appwrite/appwrite.dart';
import 'package:auth_system/data/service/appwrite_auth_service.dart';
import 'package:auth_system/widget/make_elevated_button.dart';
import 'package:auth_system/widget/make_text.dart';
import 'package:auth_system/widget/make_text_button.dart';
import 'package:auth_system/widget/make_text_field.dart';
import 'package:auth_system/widget/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _showPassword = true;
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _pass;

  late FocusNode femail;
  late FocusNode fpass;
  late FocusNode fname;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _pass = TextEditingController();
    femail = FocusNode();
    fname = FocusNode();
    fpass = FocusNode();
  }

  @override
  void dispose() {
    fname.dispose();
    femail.dispose();
    fpass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.09,
            left: size.width * 0.02,
            right: size.width * 0.02,
          ),
          child: Column(
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
                "Sign Up",
                fontWeight: FontWeight.bold,
                textColor: Colors.grey,
                size: Theme.of(context).textTheme.headline6!.fontSize,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              makeTextField(
                autofocus: true,
                controller: _name,
                hintText: "Enter your Full Name",
                obscureText: false,
                focusNode: fname,
                onFieldSubmitted: (val) {
                  fname.unfocus();
                  FocusScope.of(context).requestFocus(femail);
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: size.height * 0.013,
              ),
              makeTextField(
                controller: _email,
                hintText: "Enter your Email",
                obscureText: false,
                focusNode: femail,
                onFieldSubmitted: (val) {
                  femail.unfocus();
                  FocusScope.of(context).requestFocus(fpass);
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: size.height * 0.013,
              ),
              makeTextField(
                focusNode: fpass,
                textInputAction: TextInputAction.done,
                controller: _pass,
                hintText: "Enter your Password",
                obscureText: _showPassword,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  child: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              makeElevatedButton(
                "Create an Account",
                textSize: Theme.of(context).textTheme.button!.fontSize!,
                onPressed: () async {
                  var email = _email.text;
                  var name = _name.text;
                  var pass = _pass.text;
                  try {
                    await AuthAppwrite.instance!.signup(
                      userID: '',
                      name: name,
                      email: email,
                      password: pass,
                    );
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: makeText(
                          "Successfully Create Your Account",
                        ),
                      ),
                    );
                    pop(context);
                  } on AppwriteException catch (e) {
                    if (kDebugMode) print(e.message);
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
                  makeText("If you have an account?"),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  makeTextButton("Login", onPressed: () {
                    pop(context);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
