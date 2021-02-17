import 'package:digitalt_application/Screens/Authenticate/authenticate.dart';
import 'package:digitalt_application/homePage.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either HomePage or Authenticate widget
    return Authenticate();
  }
}


// onTap: () {}, child: Icon(Icons.account_circle)))