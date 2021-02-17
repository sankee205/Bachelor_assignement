import 'package:digitalt_application/Permanent%20services/BaseAppBar.dart';
import 'package:digitalt_application/Permanent%20services/BaseAppDrawer.dart';
import 'package:digitalt_application/caseItem.dart';
import 'package:digitalt_application/homePage.dart';
import 'package:digitalt_application/infoPage.dart';
import 'package:flutter/material.dart';

class CasePage extends StatelessWidget {
  final CaseItem caseItem;

  CasePage({Key key, @required this.caseItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this is the appbar for the home page
      appBar: BaseAppBar(
        title: Text('DIGI-TALT'),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),
      //here starts the body
      body: Center(
        child: Container(
            width: 1200,
            alignment: Alignment.topCenter,
            //this is the backgound image of the case
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(caseItem.image),
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
              ),
            ),
            //here starts the case
            child: Container(
              width: 800,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: <Widget>[
                    //back button
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0,
                          MediaQuery.of(context).size.height / 4, 0.0, 0.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          borderRadius: BorderRadius.circular(35),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              //this is the title
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text(
                                  caseItem.title,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //in this row you find author and published date
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(Icons.person),
                                  Text(caseItem.author),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(Icons.date_range),
                                  Text(caseItem.publishedDate)
                                ],
                              ),
                              //this is the description of the case. the main text
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(caseItem.description),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
