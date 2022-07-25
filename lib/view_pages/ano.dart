import 'package:appwrite/appwrite.dart';
import 'package:auth_system/data/service/appwrite_auth_service.dart';
import 'package:auth_system/main.dart';
import 'package:auth_system/widget/make_text.dart';
import 'package:auth_system/widget/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnoPage extends StatefulWidget {
  const AnoPage({Key? key}) : super(key: key);

  @override
  State<AnoPage> createState() => _AnoPageState();
}

class _AnoPageState extends State<AnoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anonymous User"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountName: makeText(
                "Anonymous User",
              ),
              accountEmail: makeText("anonymous@appwrite.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: makeText(
                  "A",
                  textColor: Colors.black,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            makeText(
              "Forget all the reasons it won’t work and believe the one reason that it will!",
              fontWeight: FontWeight.bold,
              size: Theme.of(context).textTheme.headline6!.fontSize!,
            ),
            makeText("Anonymous Quotes"),
          ],
        ),
      ),
    );
  }
}
