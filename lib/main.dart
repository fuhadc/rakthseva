import 'package:flutter/material.dart';
import 'package:rakthseva/screens/form.dart';

import 'controller/user.dart';
import 'screens/home.dart';
import 'screens/settings.dart';
import 'widget/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final usr = User(
        userid: 'aasdasd', username: 'asdfadfasdf', password: 'asdfasdfdfs', firstName: "asdsad", lastName: "Asdasd", email: "Dasfasdfdfs@fsdf.cdfssd");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: HomePage(
        userData: usr,
      ),
    );
  }
}
