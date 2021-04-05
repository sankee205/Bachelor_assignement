import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/firestoreService.dart';
import 'package:get_it/get_it.dart';
import 'package:digitalt_application/navigationService.dart';
import 'package:digitalt_application/dialogService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FirestoreService());
}
