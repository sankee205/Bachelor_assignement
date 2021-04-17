import 'package:digitalt_application/AdminPages/AdminPage.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Pages/ProfilePage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../Layouts/BaseAppBar.dart';
import '../Layouts/BaseAppDrawer.dart';

/**
 * this is the add case form. it is used by the admin to add cases
 * to the database and the app.
 *
 * this page is only available on web
 */
class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String uid;
  final String phonenumber;
  final String role;

  const EditProfilePage({
    Key key,
    @required this.name,
    @required this.email,
    @required this.uid,
    @required this.phonenumber,
    @required this.role,
  }) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  DatabaseService db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String id;
  String userRole;
  final fullname = TextEditingController();
  final emailAdress = TextEditingController();
  final number = TextEditingController();

  @override
  void initState() {
    super.initState();
    setCaseItem();
  }

  ///this method will set the caseitems in page from input fields to the widget
  Future setCaseItem() async {
    setState(() {
      fullname.text = widget.name;
      emailAdress.text = widget.email;
      number.text = widget.phonenumber;
      id = widget.uid;
      userRole = widget.role;
    });
  }

  ///this methods will update the case in firebase
  bool changeProfileData() {
    bool success = true;

    dynamic result = db.updateUserData(
        id, fullname.text, emailAdress.text, number.text, userRole);
    if (result != null) {
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  @override
  void dispose() {
    fullname.dispose();
    emailAdress.dispose();
    number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: BaseAppBar(
        title: Text(
          'DIGI-TALT.NO',
          style: TextStyle(color: Colors.white),
        ),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      bottomNavigationBar: BaseBottomAppBar(),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            width: 800,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Rediger din Brukerinformasjon',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    Text(
                      'Name',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // name textfield
                    Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: TextFormField(
                        controller: fullname,
                        validator: (v) {
                          if (v.trim().isEmpty) return 'Please enter something';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Email',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: TextFormField(
                        controller: emailAdress,
                        validator: (v) {
                          if (v.trim().isEmpty) return 'Please enter something';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Telefon nummer',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: TextFormField(
                        controller: number,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          LengthLimitingTextInputFormatter(8),
                        ],
                        validator: (v) {
                          if (v.trim().isEmpty) return 'Please enter something';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    Center(
                      child: FlatButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            showAlertPublishDialog(context);
                          }
                        },
                        child: Text('Submit'),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///creates an alertdialog before pushing changes to firebase
  Widget showAlertPublishDialog(BuildContext context) {
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
        if (changeProfileData()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Publisere endring av profildata"),
      content: Text("Er du sikker på at du vil publisere disse endringen?"),
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
