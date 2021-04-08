import 'package:digitalt_application/AdminPages/AdminPage.dart';
import 'package:digitalt_application/Pages/ProfilePage.dart';
import 'package:digitalt_application/Pages/SettingsPage.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digitalt_application/Services/auth.dart';

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

class _BaseAppDrawerState extends State<BaseAppDrawer> {
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
              'DIGI-TALT',
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
                  context, MaterialPageRoute(builder: (context) => InfoPage()));
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
          ListTile(
            leading: Icon(Icons.admin_panel_settings),
            title: Text('Admin'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Logg ut'),
            onTap: () async {
              try {
                await _auth.signOut();
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}
