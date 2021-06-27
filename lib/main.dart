import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lastexam/screens/home_screen.dart';
import 'package:lastexam/screens/login_screen.dart';

Future<void> main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
      },
    );
  }
}
