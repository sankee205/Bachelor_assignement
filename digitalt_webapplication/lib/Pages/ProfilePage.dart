import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/LoginRegister/Views/startUpView.dart';
import 'package:digitalt_application/Pages/EditProfilePage.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// this page will display the user profile
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  BaseUser _currentUser;

  @override
  void initState() {
    super.initState();
    _setBaseUser();
  }

  _setBaseUser() async {
    setState(() {
      _currentUser = _auth.getFirebaseUser();
    });
  }

  _signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this is the appbar for the home page
      appBar: BaseAppBar(
        title: Text(
          'DIGI-TALT.NO',
          style: TextStyle(color: Colors.white),
        ),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      bottomNavigationBar: BaseBottomAppBar(),

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),

      //here comes the body of the home page
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Container(
                width: 400,
                child: Material(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Din Profildata',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.person,
                        size: 50,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Navn: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          _currentUser == null
                              ? Text('')
                              : Text(
                                  _currentUser.fullName,
                                  style: TextStyle(fontSize: 15),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Email: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          _currentUser == null
                              ? Text('')
                              : Text(
                                  _currentUser.email,
                                  style: TextStyle(fontSize: 15),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Mobilnummer: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          _currentUser == null
                              ? Text('')
                              : Text(
                                  _currentUser.phonenumber,
                                  style: TextStyle(fontSize: 15),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Brukertype: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          _currentUser == null
                              ? Text('')
                              : Text(
                                  _currentUser.userRole,
                                  style: TextStyle(fontSize: 15),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _auth.isUserAnonymous()
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Text(
                                          'Som gjest er ingen saker tilgjengelige'),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('Logg inn for å lese saker'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _signOut();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StartUpView()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Logg inn'),
                                    ))
                              ],
                            )
                          : ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfilePage(
                                              email: _currentUser.email,
                                              name: _currentUser.fullName,
                                              phonenumber:
                                                  _currentUser.phonenumber,
                                              uid: _currentUser.uid,
                                              role: _currentUser.userRole,
                                              myCases: _currentUser.myCases,
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Rediger'),
                              )),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
