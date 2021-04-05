import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/baseModel.dart';
import 'package:digitalt_application/locator.dart';
import 'package:digitalt_application/navigationService.dart';
import 'package:digitalt_application/routeNames.dart';

class StartUpViewModel extends BaseModel {
  final AuthService _authenticationService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomePageRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
