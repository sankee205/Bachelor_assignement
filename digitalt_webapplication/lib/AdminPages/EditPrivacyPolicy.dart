import 'package:digitalt_application/AdminPages/AdminPage.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../Layouts/BaseAppBar.dart';
import '../Layouts/BaseAppDrawer.dart';

///
///this is the add case page. in this page, users with admin access
///can add new articles to the server
///
class EditPrivacyPolicy extends StatefulWidget {
  @override
  _EditPrivacyPolicyState createState() => _EditPrivacyPolicyState();
}

class _EditPrivacyPolicyState extends State<EditPrivacyPolicy> {
  //get the database service
  final DatabaseService _db = DatabaseService();

  //creates a form key to evaluate the form
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  bool _updateGdpr() {
    bool success = true;
    var result = _db.updateGdprContent(_textController.text, _getDate());
    print(result);
    if (result != null) {
      success = true;
    } else {
      print('failed to upload case item');
      success = false;
    }
    return success;
  }

  _getGdpr() async {
    List resultList = await _db.getGdprContent();
    var result = resultList[0];
    setState(() {
      _textController.text = result['text'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGdpr();
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
        widgets: <Widget>[
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular((20))),
            ),
          ),
        ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Rediger Sikerhetserklæring (GDPR)',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [Text("Dato: "), Text(_getDate())],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        FloatingActionButton(
                          heroTag: 'filebutton',
                          onPressed: getFile,
                          child: Icon(Icons.file_upload),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Her kan du laste opp tekstfil av typen (.txt)')
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Hoveddel',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                          hintText: 'Skriv inn din GDPR her...'),
                      minLines: 1,
                      maxLines: 200,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _showAlertPublishDialog(context);
                          }
                        },
                        child: Text('Publiser'),
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: 20,
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

  ///
  ///this function gets the current date
  ///and formats it before returning the value
  String _getDate() {
    DateTime selectedDate = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy H:mm');
    final String formatted = formatter.format(selectedDate);
    return formatted;
  }

  /// creates an alert dialog when trying to publish the
  /// new article
  Widget _showAlertPublishDialog(BuildContext context) {
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
        Navigator.of(context, rootNavigator: true).pop();
        if (_updateGdpr()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminPage()));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Publisering av endringer"),
      content: Text(
          "Er du sikker på at du vil publisere endringene på sikkerhetserklæringen?"),
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

  Future getFile() async {
    FilePickerCross myFile = await FilePickerCross.importFromStorage(
        type: FileTypeCross
            .any, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
        fileExtension:
            'txt, md' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
        );
    _textController.text = myFile.toString();
  }
}
