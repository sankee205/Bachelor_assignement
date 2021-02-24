import 'package:digitalt_application/homePage.dart';
import 'package:flutter/material.dart';
import 'package:digitalt_application/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/user.dart';

/*
 * This is the main file that wil start running when the app is open and
 * it redirects to the homepage file to run the home page
 * @Sander Keedklang 
 * @Mathias Gjærde Forberg
 */
void main() {
  // calls the class HomePage to run
  runApp(MyApp());
}

//creates a stateful widget and returns the Homepage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
        ));
  }
}
