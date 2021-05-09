import 'package:digitalt_application/LoginRegister/Model/signUpViewModel.dart';
import 'package:digitalt_application/LoginRegister/navigationService.dart';
import 'package:digitalt_application/LoginRegister/routeNames.dart';
import 'package:digitalt_application/Pages/PrivacyPolicyPage.dart';
import 'package:digitalt_application/Pages/UserTerms.dart';

import '../locator.dart';
import '../uiHelpers.dart';
import '../Widgets/busyButton.dart';
import '../Widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  final Function toggleView;
  SignUpView({this.toggleView});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final Color logoGreen = Color(0xff25bcbb);

  final NavigationService _navigationService = locator<NavigationService>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final fullNameController = TextEditingController();

  final phonenumberController = TextEditingController();

  bool agreedToSecurityTerms = false;

  String needToAgree = '';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              MaterialButton(
                  child: Text('Logg inn'),
                  onPressed: () {
                    _navigationService.navigateTo(LoginViewRoute);
                  }),
            ],
          ),
          body: Center(
            child: Container(
              width: 800,
              child: Material(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Registrer deg',
                        style: TextStyle(
                          fontSize: 38,
                        ),
                      ),
                      verticalSpaceLarge,
                      InputField(
                        placeholder: 'Fullt navn',
                        controller: fullNameController,
                      ),
                      verticalSpaceSmall,
                      InputField(
                        placeholder: 'E-post',
                        controller: emailController,
                      ),
                      verticalSpaceSmall,
                      InputField(
                        placeholder: 'Telefonnummer',
                        controller: phonenumberController,
                      ),
                      verticalSpaceSmall,
                      InputField(
                        placeholder: 'Passord',
                        password: true,
                        controller: passwordController,
                        additionalNote:
                            'Passordet må minst inneholde 6 karakterer.',
                      ),
                      verticalSpaceSmall,
                      Row(
                        children: [
                          Text('Jeg godkjenner sikkerhetsvilkårene '),
                          SizedBox(
                            width: 20,
                          ),
                          Checkbox(
                            value: agreedToSecurityTerms,
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              setState(() {
                                agreedToSecurityTerms = value;
                                if (value) {
                                  needToAgree = '';
                                }
                              });
                            },
                          ),
                          SizedBox(),
                          MaterialButton(
                            child: Text('Les sikkerhetserklæring her'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserTermsPage()));
                            },
                          ),
                        ],
                      ),
                      Text(
                        needToAgree,
                        style: TextStyle(color: Colors.red),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (agreedToSecurityTerms) {
                                model.setSelectedRole('User');
                                model.signUp(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phonenumber: phonenumberController.text,
                                    fullName: fullNameController.text);
                              } else {
                                setState(() {
                                  needToAgree =
                                      'Du må godkjenne sikkerthetsvilkårene';
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Registrer deg',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(primary: logoGreen),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
