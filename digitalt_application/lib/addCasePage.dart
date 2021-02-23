import 'package:digitalt_application/Permanent%20services/BaseBottomAppBar.dart';
import 'package:digitalt_application/Permanent%20services/MyForm.dart';
import 'package:flutter/material.dart';

import 'Permanent services/BaseAppBar.dart';
import 'Permanent services/BaseAppDrawer.dart';

class AddCasePage extends StatefulWidget {
  @override
  _AddCasePageState createState() => _AddCasePageState();
}

class _AddCasePageState extends State<AddCasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this is the appbar for the home page
      appBar: BaseAppBar(
        title: Text('DIGI-TALT'),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      bottomNavigationBar: BaseBottomAppBar(),

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),

      //here comes the body of the home page
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Add Article',
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                decoration:
                    InputDecoration(hintText: 'Title', labelText: 'Title'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Introduction', labelText: 'Introduction'),
                keyboardType: TextInputType.text,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text('Description'),
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCasePage()));
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.add,
                          size: 10.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Paragraph', labelText: 'Paragraph'),
                    keyboardType: TextInputType.text,
                  ),
                  Column(
                    children: [],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
