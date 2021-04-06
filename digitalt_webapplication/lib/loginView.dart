import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/uiHelpers.dart';
import 'package:digitalt_application/busyButton.dart';
import 'package:digitalt_application/inputField.dart';
import 'package:digitalt_application/textLink.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:digitalt_application/loginViewModel.dart';
import 'package:digitalt_application/Pages/VippsLoginPage.dart';

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
                        Text(
                          'Logg inn her for å se alt av innhold hos DIGI-TALT',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontSize: 28),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Skriv inn e-post og passord her for å lese saker hos DIGI-TALT',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontSize: 14),
                        ),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            obscureText: true,
                            validator: (val) => val.length < 6
                                ? 'Enter a password 6+ characters long'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            style: TextStyle(color: Colors.black)),
                        MaterialButton(
                          elevation: 0,
                          minWidth: 210,
                          height: 50,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() => error =
                                    'Could not log in with those credentials!');
                              }
                            }
                          },
                          color: logoGreen,
                          child: Text('Logg inn',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 20),
                        MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VippsLoginPage()));
                            },
                            child: Image.asset(
                              'vipps/login_image.png',
                              width: 200,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 50.0),
                          child: TextButton(
                            child: Text('sign in anon'),
                            onPressed: () async {
                              dynamic result = await _auth.signInAnon();
                              if (result == null) {
                                print('error signing in');
                              } else {
                                print('signed in');
                                print(result);
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _buildFooterLogo(),
                        )
                      ],
                    ),
                  )),
            ));
  }

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('DIGI-TALT',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
