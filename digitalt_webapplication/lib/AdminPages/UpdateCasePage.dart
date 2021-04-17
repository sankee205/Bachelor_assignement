import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalt_application/AdminPages/AdminPage.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Layouts/BaseCaseItem.dart';
import 'package:digitalt_application/Layouts/BaseTextFields.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart' as html;
import 'package:path/path.dart' as Path;

import 'package:mime_type/mime_type.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../Pages/HomePage.dart';
import '../Layouts/BaseAppBar.dart';
import '../Layouts/BaseAppDrawer.dart';

/**
 * this is the add case form. it is used by the admin to add cases
 * to the database and the app.
 *
 * this page is only available on web
 */
class UpdateCasePage extends StatefulWidget {
  final String caseTitle;
  final String caseImageUrl;
  final String caseIntroduction;
  final String caseId;
  final List caseText;
  final List caseAuthorList;
  final String caseDate;

  const UpdateCasePage(
      {Key key,
      @required this.caseTitle,
      @required this.caseIntroduction,
      @required this.caseText,
      @required this.caseDate,
      @required this.caseAuthorList,
      @required this.caseImageUrl,
      @required this.caseId})
      : super(key: key);
  @override
  _UpdateCasePageState createState() => _UpdateCasePageState();
}

class _UpdateCasePageState extends State<UpdateCasePage> {
  DatabaseService db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String id;
  String imageUrl;
  final title = TextEditingController();
  final introduction = TextEditingController();
  String date;
  static List descriptionList = [];
  static List authorList = [];

  Image _imageWidget;
  MediaInfo mediaInfo;
  String richText;

  @override
  void initState() {
    super.initState();
    setCaseItem();
  }

  ///this method will set the caseitems in page from input fields to the widget
  Future setCaseItem() async {
    setState(() {
      imageUrl = widget.caseImageUrl;
      _imageWidget = Image.network(widget.caseImageUrl);
      id = widget.caseId;
      date = widget.caseDate;
      title.text = widget.caseTitle;
      introduction.text = widget.caseIntroduction;
      descriptionList = widget.caseText;
      authorList = widget.caseAuthorList;
    });
  }

  ///this methods will update the case in firebase
  bool addCaseItem() {
    bool success = true;
    if (mediaInfo == null) {
      var result = db.updateCaseItemData(id, imageUrl, title.text, authorList,
          date, introduction.text, descriptionList);
      if (result != null) {
        success = true;
      } else {
        print('failed to upload case item');
        success = false;
      }
    } else {
      db.uploadFile(mediaInfo).then((value) {
        String imageUri = value.toString();
        if (imageUri != null) {
          var result = db.updateCaseItemData(id, imageUri, title.text,
              authorList, date, introduction.text, descriptionList);
          if (result != null) {
            success = true;
          } else {
            print('failed to upload case item');
            success = false;
          }
        } else {
          print('imageUri is null');
          success = false;
        }
      });
    }
    return success;
  }

//gets the image that is added
  Future<void> getImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    mediaInfo = mediaData;
    String mimeType = mime(Path.basename(mediaData.fileName));
    html.File mediaFile =
        new html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        _imageWidget = Image.memory(
          mediaData.data,
          fit: BoxFit.contain,
        );
      });
    }
  }

  @override
  void dispose() {
    title.dispose();
    introduction.dispose();
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
                        'Add Article',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: _imageWidget == null
                          ? Text('No image selected.')
                          : _imageWidget,
                    ),
                    FloatingActionButton(
                      onPressed: getImage,
                      heroTag: 'PickImage',
                      child: Icon(Icons.add_a_photo),
                    ),

                    Text(
                      'Title',
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
                        controller: title,
                        decoration:
                            InputDecoration(hintText: 'Enter your Title'),
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
                      'Introduction',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: TextFormField(
                        controller: introduction,
                        decoration: InputDecoration(
                            hintText: 'Enter your Introduction'),
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
                    Row(
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(date),
                      ],
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    Text(
                      'Description',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    ..._getParagraphs(),
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
    for (int i = 0; i < descriptionList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(
                child:
                    BaseTextFields(descriptionList, i, 5, 'Enter a paragraph')),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(
                i == descriptionList.length - 1, i, descriptionList),
          ],
        ),
      ));
    }
    return friendsTextFields;
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
        Navigator.of(context, rootNavigator: true).pop();
        if (addCaseItem()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminPage()));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Publisere endring av artikkel"),
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

// creates a list of authors
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

  /// creates a alert dialog
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
