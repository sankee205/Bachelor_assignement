import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:digitalt_application/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/user.dart';

import 'AppManagement/ThemeManager.dart';

/*
 * This is the main file that wil start running when the app is open and
 * it redirects to the homepage file to run the home page
 * @Sander Keedklang 
 * @Mathias Gjærde Forberg
 */

import 'startUpView.dart';
import 'package:flutter/material.dart';
import 'navigationService.dart';
import 'dialogService.dart';
import 'dialogManager.dart';
import 'router.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupLocator();

  // calls the class HomePage to run
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: MyApp(),
  ));
  // Register all the models and services before the app starts
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIGI-TALT',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 9, 202, 172),
        backgroundColor: Color.fromARGB(255, 26, 27, 30),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      home: StartUpView(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
    );
  }
}


