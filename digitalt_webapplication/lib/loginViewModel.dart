import 'routeNames.dart';
import 'locator.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'Services/dialogService.dart';
import 'navigationService.dart';
import 'package:flutter/foundation.dart';

import 'models/baseModel.dart';

class LoginViewModel extends BaseModel {
  final AuthService _authenticationService =
      locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomePageRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}