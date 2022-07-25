import 'package:appwrite/appwrite.dart';
import 'package:auth_system/data/model/user.dart';
import 'package:auth_system/data/service/appwrite_auth_service.dart';
import 'package:auth_system/main.dart';
import 'package:auth_system/widget/make_elevated_button.dart';
import 'package:auth_system/widget/make_text.dart';
import 'package:auth_system/widget/make_text_field.dart';
import 'package:auth_system/widget/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserData user;

  const HomePage({Key? key, required this.user}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _updateName;
  late TextEditingController _updateEmail;
  late TextEditingController _pass;
  late TextEditingController _changeps;
  late TextEditingController _oldps;

  bool _obsecure = true;
  bool _obsecure1 = true;

  @override
  void initState() {
    super.initState();
    _updateName = TextEditingController();
    _updateEmail = TextEditingController();
    _pass = TextEditingController();
    _changeps = TextEditingController();
    _oldps = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var username = widget.user.name;
    var userValidate = username.toUpperCase();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: makeText("Auth System"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: makeText(
                widget.user.name,
              ),
              accountEmail: makeText(widget.user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: makeText(
                  userValidate.substring(0, 1).toUpperCase(),
                  fontWeight: FontWeight.bold,
                  size: Theme.of(context).textTheme.headline6!.fontSize!,
                ),
              ),
            ),
            ListTile(
              title: makeText("Logout"),
              leading: const Icon(Icons.logout),
              onTap: () async {
                try {
                  await AuthAppwrite.instance!.logout();

                  if (!mounted) return;
                  pushReplacement(context, const MainPage());
                } on AppwriteException catch (e) {
                  if (kDebugMode) print(e.message);
                }
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            // Change Name
            makeTextField(
              hintText: "Change Your Name",
              controller: _updateName,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            makeElevatedButton(
              "Change Name",
              onPressed: () async {
                var name = _updateName.text;
                try {
                  await AuthAppwrite.instance!.updateName(name: name);

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: makeText("Name Change"),
                    ),
                  );
                  _updateName.clear();
                  await AuthAppwrite.instance!.logout();

                  if (!mounted) return;
                  push(context, const MainPage());
                } on AppwriteException catch (e) {
                  if (kDebugMode) print(e.message);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: makeText(e.message!),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Divider(
              height: 3,
              thickness: 7.0,
              color: Colors.amberAccent,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            // change email
            makeTextField(controller: _updateEmail, hintText: "Change Email"),
            SizedBox(
              height: size.height * 0.01,
            ),
            makeTextField(controller: _pass, hintText: "Your Password"),
            SizedBox(
              height: size.height * 0.02,
            ),
            makeElevatedButton(
              "Change Email",
              onPressed: () async {
                var email = _updateEmail.text;
                var pass = _pass.text;

                try {
                  await AuthAppwrite.instance!.updateEmail(
                    email: email,
                    password: pass,
                  );

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: makeText("Update Email"),
                    ),
                  );
                  _updateName.clear();
                  await AuthAppwrite.instance!.logout();

                  if (!mounted) return;
                  push(context, const MainPage());
                } on AppwriteException catch (e) {
                  if (kDebugMode) print(e.message);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: makeText(e.message!),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Divider(
              height: 3,
              thickness: 7.0,
              color: Colors.amberAccent,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            // change password
            makeTextField(
              controller: _oldps,
              hintText: "Enter Old Password",
              obscureText: _obsecure,
              suffixIcon: GestureDetector(
                child:
                    Icon(_obsecure ? Icons.visibility : Icons.visibility_off),
                onTap: () {
                  setState(() {
                    _obsecure = !_obsecure;
                  });
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            makeTextField(
              controller: _changeps,
              hintText: "Change New Password",
              obscureText: _obsecure1,
              suffixIcon: GestureDetector(
                child:
                    Icon(_obsecure1 ? Icons.visibility : Icons.visibility_off),
                onTap: () {
                  setState(
                    () {
                      _obsecure1 = !_obsecure1;
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            makeElevatedButton(
              "Change Password",
              onPressed: () async {
                var pass = _changeps.text;
                var old = _oldps.text;
                try {
                  await AuthAppwrite.instance!.updatePassword(
                    password: pass,
                    oldpw: old,
                  );

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: makeText("Change password"),
                    ),
                  );
                  _changeps.clear();
                  await AuthAppwrite.instance!.logout();

                  if (!mounted) return;
                  push(context, const MainPage());
                } on AppwriteException catch (e) {
                  if (kDebugMode) print(e.message);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: makeText(e.message!),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
