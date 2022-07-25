import 'package:auth_system/data/model/user.dart';
import 'package:auth_system/data/service/appwrite_auth_service.dart';
import 'package:auth_system/view_pages/auth_pages/login.dart';
import 'package:auth_system/view_pages/homepages.dart';
import 'package:auth_system/view_pages/splashpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData>(
      future: AuthAppwrite.instance!.knowUserLogin(),
      builder: (_, snapshot) {
        //
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage();
        }
        //
        if (snapshot.hasData) {
          return HomePage(
            user: snapshot.data!,
          );
        }
        //
        return const LoginPage();
      },
    );
  }
}
