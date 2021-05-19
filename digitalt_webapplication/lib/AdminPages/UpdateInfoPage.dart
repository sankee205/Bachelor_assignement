import 'package:digitalt_application/AdminPages/AdminPage.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Layouts/BaseTextFields.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';

import 'package:universal_html/html.dart' as html;
import 'package:path/path.dart' as Path;

import 'package:mime_type/mime_type.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../Layouts/BaseAppBar.dart';
import '../Layouts/BaseAppDrawer.dart';

/*
 * this is the add case form. it is used by the admin to add cases
 * to the database and the app.
 *
 * this page is only available on web
 */
class UpdateInfoPage extends StatefulWidget {
  @override
  _UpdateInfoPageState createState() => _UpdateInfoPageState();
}

class _UpdateInfoPageState extends State<UpdateInfoPage> {
  final Color logoGreen = Color(0xff25bcbb);

  final DatabaseService _db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String _contactUrl;
  String _textUrl;
  String _backgroundUrl;
  final _email = TextEditingController();
  final _tlf = TextEditingController();

  String _date;
  static List _textList = [];
  static List _authorList = [];

  Text _saveImageText = Text(
    'Lagre oppdaterte bilder',
    style: TextStyle(fontSize: 15),
  );

  Image _contactPhoto;
  Image _textPhoto;
  Image _backgroundPhoto;

  MediaInfo _contactPhotoInfo;
  MediaInfo _textPhotoInfo;
  MediaInfo _backgroundPhotoInfo;

  @override
  void initState() {
    super.initState();
    _fetchCaseItem();
  }

  Future _fetchCaseItem() async {
    List resultList = await _db.getInfoPageContent();
    var result = resultList[0];
    setState(() {
      _textList = result['text'];
      _authorList = result['author'];
      _contactUrl = result['contactPhoto'];
      _contactPhoto = Image(
        width: 500,
        image: NetworkImage(_contactUrl),
        fit: BoxFit.fitWidth,
      );
      _date = result['date'];
      _email.text = result['email'];
      _textUrl = result['textPhoto'];
      _textPhoto = Image(
        width: 500,
        image: NetworkImage(_textUrl),
        fit: BoxFit.fitWidth,
      );
      ;
      _tlf.text = result['tlf'];
      _backgroundUrl = result['backgroundPhoto'];
      _backgroundPhoto = Image(
        width: 500,
        image: NetworkImage(_backgroundUrl),
        fit: BoxFit.fitWidth,
      );
      ;
    });
  }

  bool _updateInfoData() {
    bool success = true;
    var result = _db.updateInfoPageContent(_textUrl, _contactUrl, _email.text,
        _tlf.text, _textList, _authorList, _date, _backgroundUrl);
    if (result != null) {
      success = true;
    } else {
      print('failed to upload case item');
      success = false;
    }
    return success;
  }

  Future _savePhotoState() async {
    if (_contactPhotoInfo != null) {
      String imageUri;
      await _db.uploadFile(_contactPhotoInfo).then((value) {
        imageUri = value.toString();
      });
      setState(() {
        _contactUrl = imageUri;
      });
    }
    if (_textPhotoInfo != null) {
      String imageUri;
      await _db.uploadFile(_textPhotoInfo).then((value) {
        imageUri = value.toString();
      });
      setState(() {
        _textUrl = imageUri;
      });
    }
    if (_backgroundPhotoInfo != null) {
      String imageUri;
      await _db.uploadFile(_backgroundPhotoInfo).then((value) {
        imageUri = value.toString();
      });
      setState(() {
        _backgroundUrl = imageUri;
      });
    }
    if (_contactPhotoInfo != null ||
        _backgroundPhotoInfo != null ||
        _textPhotoInfo != null) {
      setState(() {
        _saveImageText = Text(
          'Opplastning Fullført',
          style: TextStyle(color: Colors.green, fontSize: 15),
        );
      });
    } else {
      setState(() {
        _saveImageText = Text(
          'Ingen nye bilder, beholder de eksisterende',
          style: TextStyle(color: Colors.red, fontSize: 15),
        );
      });
    }
  }

//gets the image that is added
  Future<void> _getContactImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    _contactPhotoInfo = mediaData;
    String mimeType = mime(Path.basename(mediaData.fileName));
    html.File mediaFile =
        new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        _contactPhoto = Image.memory(
          mediaData.data,
          fit: BoxFit.fitWidth,
        );
      });
    }
  }

  Future<void> _getTextImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    _textPhotoInfo = mediaData;
    String mimeType = mime(Path.basename(mediaData.fileName));
    html.File mediaFile =
        new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        _textPhoto = Image.memory(
          mediaData.data,
          fit: BoxFit.fitWidth,
        );
      });
    }
  }

  Future<void> _getBackgroundImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    _backgroundPhotoInfo = mediaData;
    String mimeType = mime(Path.basename(mediaData.fileName));
    html.File mediaFile =
        new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        _backgroundPhoto = Image.memory(
          mediaData.data,
          fit: BoxFit.fitWidth,
        );
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _tlf.dispose();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Rediger Informasjonsside',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Center(
                          child:
                              _contactPhoto == null ? Text('') : _contactPhoto,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: _getContactImage,
                          heroTag: 'contactImage',
                          child: Icon(Icons.add_a_photo),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Kontakt Bilde')
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Center(
                          child: _textPhoto == null ? Text('') : _textPhoto,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: _getTextImage,
                          heroTag: 'textImage',
                          child: Icon(Icons.add_a_photo),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Informasjons Bilde')
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Center(
                          child: _backgroundPhoto == null
                              ? Text('')
                              : _backgroundPhoto,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: _getBackgroundImage,
                          heroTag: 'backgroundImage',
                          child: Icon(Icons.add_a_photo),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Bakgrunnsbilde')
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        FlatButton(
                          onPressed: () {
                            _savePhotoState();
                          },
                          child: Icon(Icons.save),
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        _saveImageText,
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      'Email',
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
                        controller: _email,
                        decoration: InputDecoration(
                            hintText:
                                'Skriv inn email du vil bli kontaktet på'),
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
                      'TLF',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: TextFormField(
                        controller: _tlf,
                        decoration: InputDecoration(
                            hintText: 'Skriv inn tlf du vil bli kontaktet på'),
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
                      'Forfatter',
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
                    Text(
                      'Dato',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        RaisedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Velg dato'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 32.0),
                          child:
                              Text("${selectedDate.toLocal()}".split(' ')[0]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    Text(
                      'Informasjonstekst',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    ..._getParagraphs(),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        'Husk å lagre bildene ved endring før du publiserer',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _showAlertPublishDialog(context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Publiser',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(primary: logoGreen),
                      ),
                    )
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
        if (_updateInfoData()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminPage()));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Publisere endring av Info side"),
      content: Text("Er du sikker på at du vil publisere denne endringen?"),
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

// creates the select date pop up view
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date = selectedDate.toString();
      });
  }

  DateTime selectedDate = DateTime.now();

  /// creates a list of paragraphs
  List<Widget> _getParagraphs() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < _textList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
                child: BaseTextFields(_textList, i, 5, 'Enter a paragraph')),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == _textList.length - 1, i, _textList),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

//creates a list of authors
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

  Widget _showAlertDialog(BuildContext context, List list, int index) {
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
        list.removeAt(index);
        setState(() {});
        Navigator.of(context, rootNavigator: true).pop();
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
}
