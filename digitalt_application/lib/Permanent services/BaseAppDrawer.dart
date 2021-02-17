import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../homePage.dart';
import '../infoPage.dart';

class BaseAppDrawer extends StatefulWidget {
  @override
  _BaseAppDrawerState createState() => _BaseAppDrawerState();
}

class _BaseAppDrawerState extends State<BaseAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
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
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            title: Text('Log in'),
            // onTap: () {
            //Navigator.push(context,
            //MaterialPageRoute(builder: (context) => LogInPage()));
            //}
          ),
        ],
      ),
    );
  }
}