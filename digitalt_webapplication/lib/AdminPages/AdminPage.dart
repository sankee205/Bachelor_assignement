import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:flutter/material.dart';

import 'AddCasePage.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final editArticle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('DIGI-TALT', style: TextStyle(color: Colors.white),),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      bottomNavigationBar: BaseBottomAppBar(),

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),

      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Material(
              child: Container(
                width: 600,
                child: Column(children: [
                  SizedBox(height: 10,),
                  Text('Admin Console', style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Text('Legg til artikkel'),
                      Align(
                        alignment: Alignment.centerRight,
                          child: RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyForm()));
                        },
                        elevation: 2.0,
                        fillColor: Colors.grey,
                        child: Icon(
                          Icons.add,
                          size: 20.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Endre Artikkel'),
                      TextFormField(
                        controller: editArticle,
                        decoration: InputDecoration(
                            hintText: 'Navn på artikkel'),
                        validator: (v) {
                          if (v.trim().isEmpty) return 'Please enter something';
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyForm()));
                          },
                          elevation: 2.0,
                          fillColor: Colors.grey,
                          child: Icon(
                            Icons.add,
                            size: 20.0,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Endre text i informasjons siden'),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyForm()));
                          },
                          elevation: 2.0,
                          fillColor: Colors.grey,
                          child: Icon(
                            Icons.add,
                            size: 20.0,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Endre kontaktinformasjon i informasjonssiden'),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyForm()));
                          },
                          elevation: 2.0,
                          fillColor: Colors.grey,
                          child: Icon(
                            Icons.add,
                            size: 20.0,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),),
                    ],
                  ),
                  SizedBox(height: 10,),

                ],
                ),
              ),
            )
          ),
        ),
      ),
    );

  }
}
