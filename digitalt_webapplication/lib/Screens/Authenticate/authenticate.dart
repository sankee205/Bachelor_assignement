import 'package:digitalt_application/LoginRegister/Views/loginView.dart';
import 'package:digitalt_application/LoginRegister/Views/signUpView.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginView(toggleView: toggleView);
    } else {
      return SignUpView(toggleView: toggleView);
    }
  }
}
