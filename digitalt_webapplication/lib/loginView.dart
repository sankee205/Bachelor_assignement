import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/uiHelpers.dart';
import 'package:digitalt_application/busyButton.dart';
import 'package:digitalt_application/inputField.dart';
import 'package:digitalt_application/textLink.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:digitalt_application/loginViewModel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Color logoGreen = Color(0xff25bcbb);

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 150,
                          child: Image.asset('assets/images/artikkel_1.jpg'),
                        ),
                        InputField(
                          placeholder: 'Email',
                          controller: emailController,
                        ),
                        verticalSpaceSmall,
                        InputField(
                          placeholder: 'Password',
                          password: true,
                          controller: passwordController,
                        ),
                        verticalSpaceMedium,
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              elevation: 0,
                              minWidth: 210,
                              height: 50,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() => error =
                                        'Could not log in with those credentials!');
                                  }
                                }
                              },
                              color: logoGreen,
                              child: Text('Logg inn',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        TextLink(
                          'Create an Account if you\'re new.',
                          onPressed: () {
                            model.navigateToSignUp();
                          },
                        )
                      ],
                    ),
                  )),
            ));
  }
}
