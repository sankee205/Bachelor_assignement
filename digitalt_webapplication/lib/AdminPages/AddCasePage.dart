import 'package:digitalt_application/AdminPages/AdminPage.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Layouts/BaseTextFields.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:intl/intl.dart';

import 'package:universal_html/html.dart' as html;
import 'package:path/path.dart' as Path;

import 'package:mime_type/mime_type.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../Layouts/BaseAppBar.dart';
import '../Layouts/BaseAppDrawer.dart';

///
///this is the add case page. in this page, users with admin access
///can add new articles to the server
///
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  //get the database service
  final DatabaseService _db = DatabaseService();

  //creates a form key to evaluate the form
  final _formKey = GlobalKey<FormState>();

  //theese are text editing controllers
  final _title = TextEditingController();
  final _introduction = TextEditingController();
  final _textController = TextEditingController();

  //creates an author list
  static List _authorList = [null];

  // this is the image to be displayed
  Image _imageWidget;

  // this is the mediainfo of the image to be displayed
  MediaInfo _mediaInfo = MediaInfo();

  //theese are bool variable to determine if the article is to be added in the different lists in firebase
  bool _addToNewCase = false;
  bool _addToPopularCase = false;

  /// this function uploads the image to firebase and
  /// adds the case to the firebase lists
  bool _addCaseItem() {
    String date = _getDate();
    bool success = true;
    _db.uploadFile(_mediaInfo).then((value) {
      String imageUri = value.toString();
      if (imageUri != null) {
        if (_addToNewCase == true) {
          _db.updateCaseByFolder('NewCases', imageUri, _title.text, _authorList,
              date, _introduction.text, _textController.text.split('/p'), null);
        }
        if (_addToPopularCase == true) {
          _db.updateCaseByFolder(
              'PopularCases',
              imageUri,
              _title.text,
              _authorList,
              date,
              _introduction.text,
              _textController.text.split('/p'),
              null);
        }
        _db.addCaseItem(imageUri, _title.text, _authorList, date,
            _introduction.text, _textController.text.split('/p'));

        success = true;
      } else {
        print('imageUri is null');
        success = false;
      }
    });
    return success;
  }

//gets the image that is added
  Future<void> _getImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    _mediaInfo = mediaData;
    String mimeType = mime(Path.basename(mediaData.fileName));
    html.File mediaFile =
        new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        _imageWidget = Image.memory(
          mediaData.data,
          fit: BoxFit.fitWidth,
        );
      });
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _introduction.dispose();
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
                        'Legg til ny artikkel',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: _imageWidget == null
                          ? Text('Bilde er ikke valgt.')
                          : _imageWidget,
                    ),
                    FloatingActionButton(
                      onPressed: _getImage,
                      heroTag: 'Velg bilde fra maskinen',
                      child: Icon(Icons.add_a_photo),
                    ),
                    Text(
                      'Tittel',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: TextFormField(
                        controller: _title,
                        decoration:
                            InputDecoration(hintText: 'Skriv inn tittel her'),
                        validator: (v) {
                          if (v.trim().isEmpty)
                            return 'Dette feltet kan ikke være tomt';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Ingress',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: TextFormField(
                        controller: _introduction,
                        decoration:
                            InputDecoration(hintText: 'Skriv inn ingress her'),
                        validator: (v) {
                          if (v.trim().isEmpty)
                            return 'Dette feltet kan ikke være tomt';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Forfatter/ Forfattere',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    ..._getAuthors(),
                    SizedBox(
                      height: 5,
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
                          hintText: 'Skriv inn din artikkel her...'),
                      minLines: 1,
                      maxLines: 200,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text('Legg til i siste nytt? '),
                        SizedBox(
                          width: 20,
                        ),
                        Checkbox(
                          value: _addToNewCase,
                          checkColor: Colors.green,
                          onChanged: (bool value) {
                            setState(() {
                              _addToNewCase = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text('Legg til i populære saker? '),
                        SizedBox(
                          width: 20,
                        ),
                        Checkbox(
                          value: _addToPopularCase,
                          checkColor: Colors.green,
                          onChanged: (bool value) {
                            setState(() {
                              _addToPopularCase = value;
                            });
                          },
                        ),
                      ],
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

  ///
  /// creates a list of authors
  List<Widget> _getAuthors() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < _authorList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
                child: BaseTextFields(_authorList, i, 1, 'Enter an Author')),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == _authorList.length - 1, i, _authorList),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  ///
  ///creates and alert dialog if an author is to be deleted
  ///from the list
  Widget _showAlertDialog(BuildContext context, List list, int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Nei"),
      onPressed: () {
        Navigator.of(context).pop;
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ja"),
      onPressed: () {
        list.removeAt(index);
        setState(() {});
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Slett"),
      content: Text("Er du sikker på at du vil slette?"),
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
        if (_addCaseItem()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminPage()));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Publisering av artikkel"),
      content: Text("Er du sikker på at du vil publisere denne artikkelen?"),
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

  /// add / remove button
  Widget _addRemoveButton(bool add, int index, List list) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          list.insert(list.length, null);
          setState(() {});
        } else
          _showAlertDialog(context, list, index);
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
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
