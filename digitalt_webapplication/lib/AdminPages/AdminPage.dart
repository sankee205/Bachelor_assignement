import 'package:digitalt_application/AdminPages/UpdateCasePage.dart';
import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:digitalt_application/AdminPages/AddCasePage.dart';


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
                  ResponsiveGridRow(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ResponsiveGridCol(
                          lg: 12,
                          md: 12,
                          xs: 12,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  MyForm()));
                              },
                              child:Container(
                                color: Colors.grey,
                                margin: EdgeInsets.all(5),
                                height: 120,
                                child: Column(
                                children: [
                                  Icon(Icons.article, size: 50,),
                                  Text('Legg til ny artikkel')
                                ],
                              ),
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 12,
                          md: 12,
                          xs: 12,
                          child:GestureDetector(
                              onTap: () {
                                if(editArticle.text!= null && editArticle.text.length > 5){
                                  print('edit article: '+ editArticle.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  UpdateCasePage(caseTitle: editArticle.text)));
                                }

                              },
                              child:Container(
                                color: Colors.grey,
                                margin: EdgeInsets.all(5),
                                height: 120,
                                child: Column(
                                children: [
                                  Icon(Icons.article, size: 50,),
                                  Text('Rediger artikkel'),
                                  SizedBox(
                                    width: 250,
                                    child: TextField(
                                      controller: editArticle,
                                      decoration:
                                      InputDecoration(hintText: 'Tittel til artikkel', hintStyle: TextStyle(fontSize: 15)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 12,
                          md: 12,
                          xs: 12,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  MyForm()));
                              },
                              child:Container(
                                color: Colors.grey,
                                margin: EdgeInsets.all(5),
                                height: 120,
                                child: Column(
                                children: [
                                  Icon(Icons.info, size: 50,),
                                  Text('Rediger Informasjonsside Tekst')
                                ],
                              ),
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 12,
                          md: 12,
                          xs: 12,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  MyForm()));
                              },
                              child:Container(
                                color: Colors.grey,
                                margin: EdgeInsets.all(5),
                                height: 120,
                                child: Column(
                                children: [
                                  Icon(Icons.contact_phone_sharp, size: 50,),
                                  Text('Rediger KontaktInformasjon')
                                ],
                              ),
                            ),
                          ),
                        ),
                  ])
                  ]
                ),
              ),
            )
          ),
        ),
      ),
    );

  }
}
