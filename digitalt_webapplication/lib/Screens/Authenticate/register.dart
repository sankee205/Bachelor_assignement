import 'package:digitalt_application/LoginRegister/Widgets/busyButton.dart';
import 'package:digitalt_application/LoginRegister/Widgets/expansionList.dart';
import 'package:digitalt_application/LoginRegister/Widgets/inputField.dart';
import 'package:digitalt_application/LoginRegister/uiHelpers.dart';
import 'package:digitalt_application/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    var model;
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Digi-talt'),
        actions: <Widget>[
          TextButton(
            child: Text('Log in'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 38,
              ),
            ),
            verticalSpaceLarge,
            InputField(
              placeholder: 'Full Name',
              controller: fullNameController,
            ),
            verticalSpaceSmall,
            InputField(
              placeholder: 'Email',
              controller: emailController,
            ),
            verticalSpaceSmall,
            InputField(
              placeholder: 'Password',
              password: true,
              controller: passwordController,
              additionalNote: 'Password has to be a minimum of 6 characters.',
            ),
            verticalSpaceSmall,
            ExpansionList<String>(
                items: ['Admin', 'User'],
                title: model.selectedRole,
                onItemSelected: model.setSelectedRole),
            verticalSpaceMedium,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BusyButton(
                  title: 'Sign Up',
                  busy: model.busy,
                  onPressed: () {
                    model.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        fullName: fullNameController.text);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
