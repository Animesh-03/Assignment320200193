import 'package:assignment320200193/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './registerPage.dart';
import './loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool("LoggedIn") == null) prefs.setBool("LoggedIn", false);

  runApp(MaterialApp(
    title: "Login App",
    routes: {
      '/': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
      '/dashboard': (context) => Dashboard(
          userID: prefs.getString('UserID') as String,
          userName: prefs.getString('UserName') as String)
    },
    initialRoute: (prefs.getBool("LoggedIn") as bool) ? '/dashboard' : '/',
  ));
}
