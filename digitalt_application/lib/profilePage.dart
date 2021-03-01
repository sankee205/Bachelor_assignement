import 'package:digitalt_application/Permanent%20services/BaseBottomAppBar.dart';
import 'package:digitalt_application/Permanent%20services/MyForm.dart';
import 'package:digitalt_application/addCasePage.dart';
import 'package:flutter/material.dart';

import 'Permanent services/BaseAppBar.dart';
import 'Permanent services/BaseAppDrawer.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              color: Colors.grey.shade300,
              child: Center(
                child: Container(
                    width: 600,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Text('Add Article'),
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyForm()));
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.add,
                            size: 20.0,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                      ],
                    )),
              ))),
    );
  }
}
