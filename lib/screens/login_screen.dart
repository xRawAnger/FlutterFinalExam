import 'package:flutter/material.dart';
import 'package:lastexam/data/database_helper.dart';
import 'home_screen.dart';

final _formKey1 = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/login-screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController _loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: Image.asset("assets/image/login_icon.png"),
                ),
                // SizedBox(height: 40.0,),
                Container(
                  width: 200.0,
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.teal,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    controller: _loginController,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 200.0,
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, HomeScreen.routeName)
                              .then((_) {
                            Database.userID = _loginController.text;
                            print("user Saved");
                            setState(() {});
                          }),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
