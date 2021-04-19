import 'package:digitalt_application/AdminPages/AdminPage.dart';
import 'package:digitalt_application/LoginRegister/Views/startUpView.dart';
import 'package:digitalt_application/Pages/ProfilePage.dart';
import 'package:digitalt_application/Pages/SettingsPage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/firestoreService.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/HomePage.dart';
import '../Pages/InfoPage.dart';

/**
 * this is a Base App Drawer. It wil be used in all the pages.
 * It is a class made so we dont need to write this for every new 
 * page in the app/ web app
 */
class BaseAppDrawer extends StatefulWidget {
  @override
  _BaseAppDrawerState createState() => _BaseAppDrawerState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirestoreService firestoreService = FirestoreService();

final DatabaseService db = DatabaseService();
List infoList = [];
List text = [];
List author = [];
String contactPhoto = '';
String date = '';
String email = '';
String textPhoto = '';
String tlf = '';
String backgroundPhoto = '';

class _BaseAppDrawerState extends State<BaseAppDrawer> {
  String currentUserRole = 'User';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserRole();
    getInfo();
  }

  getUserRole() async {
    if (_auth.currentUser.isAnonymous) {
      currentUserRole = 'Guest';
    } else {
      User firebaseUser = _auth.currentUser;
      firestoreService.getUser(firebaseUser.uid).then((value) {
        BaseUser user = value;
        setState(() {
          currentUserRole = user.userRole;
        });
      });
    }
  }

  Future getInfo() async {
    List resultant = await db.getInfoPageContent();
    if (resultant != null) {
      var result = resultant[0];
      setState(() {
        textPhoto = result['textPhoto'];
        contactPhoto = result['contactPhoto'];
        backgroundPhoto = result['backgroundPhoto'];
        text = result['text'];
        author = result['author'];
        date = result['date'];
        email = result['email'];
        tlf = result['tlf'];
      });
    } else {
      print('resultant is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'DIGI-TALT.NO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfoPage(
                          infoList: infoList,
                          text: text,
                          author: author,
                          contactPhoto: contactPhoto,
                          date: date,
                          email: email,
                          textPhoto: textPhoto,
                          backgroundPhoto: backgroundPhoto,
                          tlf: tlf)));
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
          currentUserRole == 'Admin'
              ? ListTile(
                  leading: Icon(Icons.admin_panel_settings),
                  title: Text('Admin'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminPage()));
                  },
                )
              : SizedBox(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Logg ut'),
            onTap: () {
              showAlertSignOutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Widget showAlertSignOutDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Nei"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ja"),
      onPressed: () {
        signOut();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StartUpView()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logg ut av DIGI-TALT.NO"),
      content: Text("Er du sikker på at du vil logge ut?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
