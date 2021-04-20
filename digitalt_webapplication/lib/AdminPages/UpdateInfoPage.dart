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

/**
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
  DatabaseService db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String contactUrl;
  String textUrl;
  String backgroundUrl;
  final email = TextEditingController();
  final tlf = TextEditingController();

  String date;
  static List textList = [];
  static List authorList = [];

  Text saveImageText = Text(
    'Save new images',
    style: TextStyle(fontSize: 15),
  );

  Image contactPhoto;
  Image textPhoto;
  Image backgroundPhoto;

  MediaInfo contactPhotoInfo;
  MediaInfo textPhotoInfo;
  MediaInfo backgroundPhotoInfo;
  String richText;

  @override
  void initState() {
    super.initState();
    fetchCaseItem();
  }

  Future fetchCaseItem() async {
    List resultList = await db.getInfoPageContent();
    var result = resultList[0];
    setState(() {
      textList = result['text'];
      authorList = result['author'];
      contactUrl = result['contactPhoto'];
      contactPhoto = Image.network(contactUrl);
      date = result['date'];
      email.text = result['email'];
      textUrl = result['textPhoto'];
      textPhoto = Image.network(textUrl);
      tlf.text = result['tlf'];
      backgroundUrl = result['backgroundPhoto'];
      backgroundPhoto = Image.network(backgroundUrl);
    });
  }

  bool addCaseItem() {
    bool success = true;
    var result = db.updateInfoPageContent(textUrl, contactUrl, email.text,
        tlf.text, textList, authorList, date, backgroundUrl);
    if (result != null) {
      success = true;
    } else {
      print('failed to upload case item');
      success = false;
    }
    return success;
  }

  Future savePhotoState() async {
    if (contactPhotoInfo != null) {
      String imageUri;
      await db.uploadFile(contactPhotoInfo).then((value) {
        imageUri = value.toString();
      });
      setState(() {
        contactUrl = imageUri;
      });
    }
    if (textPhotoInfo != null) {
      String imageUri;
      await db.uploadFile(textPhotoInfo).then((value) {
        imageUri = value.toString();
      });
      setState(() {
        textUrl = imageUri;
      });
    }
    if (backgroundPhotoInfo != null) {
      String imageUri;
      await db.uploadFile(backgroundPhotoInfo).then((value) {
        imageUri = value.toString();
      });
      setState(() {
        backgroundUrl = imageUri;
      });
    }
    if (contactPhotoInfo != null ||
        backgroundPhotoInfo != null ||
        textPhotoInfo != null) {
      setState(() {
        saveImageText = Text(
          'Uploaded succesfully',
          style: TextStyle(color: Colors.green, fontSize: 15),
        );
      });
    } else {
      setState(() {
        saveImageText = Text(
          'No new Images, old will be kept',
          style: TextStyle(color: Colors.red, fontSize: 15),
        );
      });
    }
  }

//gets the image that is added
  Future<void> getContactImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    contactPhotoInfo = mediaData;
    String mimeType = mime(Path.basename(mediaData.fileName));
    html.File mediaFile =
        new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        contactPhoto = Image.memory(
          mediaData.data,
          fit: BoxFit.fitWidth,
        );
      });
    }
  }

  Future<void> getTextImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    textPhotoInfo = mediaData;
    String mimeType = mime(Path.basename(mediaData.fileName));
    html.File mediaFile =
        new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        textPhoto = Image.memory(
          mediaData.data,
          fit: BoxFit.fitWidth,
        );
      });
    }
  }

  Future<void> getBackgroundImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    backgroundPhotoInfo = mediaData;
    String mimeType = mime(Path.basename(mediaData.fileName));
    html.File mediaFile =
        new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        backgroundPhoto = Image.memory(
          mediaData.data,
          fit: BoxFit.fitWidth,
        );
      });
    }
  }

  @override
  void dispose() {
    email.dispose();
    tlf.dispose();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Edit Info Page',
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
                          child: contactPhoto == null ? Text('') : contactPhoto,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: getContactImage,
                          heroTag: 'contactImage',
                          child: Icon(Icons.add_a_photo),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Contact Photo')
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Center(
                          child: textPhoto == null ? Text('') : textPhoto,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: getTextImage,
                          heroTag: 'textImage',
                          child: Icon(Icons.add_a_photo),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Info Photo')
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Center(
                          child: backgroundPhoto == null
                              ? Text('')
                              : backgroundPhoto,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: getBackgroundImage,
                          heroTag: 'backgroundImage',
                          child: Icon(Icons.add_a_photo),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Background Photo')
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        FlatButton(
                          onPressed: () {
                            savePhotoState();
                          },
                          child: Icon(Icons.save),
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        saveImageText,
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
                        controller: email,
                        decoration:
                            InputDecoration(hintText: 'Enter your Email'),
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
                        controller: tlf,
                        decoration: InputDecoration(hintText: 'Enter your tlf'),
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
                      'Author',
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
                      'Date',
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
                          child: Text('Select date'),
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
                      'Info Text',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    ..._getParagraphs(),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        'Remember to save new images, before submitting',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (addCaseItem()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminPage()));
                            }
                          }
                        },
                        child: Text('Submit'),
                        color: Colors.green,
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
        date = selectedDate.toString();
      });
  }

  DateTime selectedDate = DateTime.now();

  /// creates a list of paragraphs
  List<Widget> _getParagraphs() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < textList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
                child: BaseTextFields(textList, i, 5, 'Enter a paragraph')),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == textList.length - 1, i, textList),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

//creates a list of authors
  List<Widget> _getAuthors() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < authorList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
                child: BaseTextFields(authorList, i, 1, 'Enter an Author')),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == authorList.length - 1, i, authorList),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  Widget showAlertDialog(BuildContext context, List list, int index) {
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
          showAlertDialog(context, list, index);
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
