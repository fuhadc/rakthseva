import 'package:flutter/material.dart';
import 'controller/user.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final usr = User(
        userid: 'aasdasd',
        username: 'asdfadfasdf',
        password: 'asdfasdfdfs',
        firstName: "asdsad",
        lastName: "Asdasd",
        email: "Dasfasdfdfs@fsdf.cdfssd");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
          ),
        ),
      ),
      home: HomePage(
        userData: usr,
      ),
    );
  }
}
