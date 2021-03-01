import 'dart:math';

import 'package:digitalt_application/Permanent%20services/BaseAppBar.dart';
import 'package:digitalt_application/Permanent%20services/BaseAppDrawer.dart';
import 'package:digitalt_application/Permanent%20services/BaseBottomAppBar.dart';
import 'package:digitalt_application/Permanent%20services/BaseCaseItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:responsive_grid/responsive_grid.dart';

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
      bottomNavigationBar: BaseBottomAppBar(),
      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),
      //here starts the body
      body: Center(
        child: Container(
            width: 1200,
            alignment: Alignment.topCenter,
            //this is the backgound image of the case

            //here starts the case
            child: Container(
              width: 800,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(caseItem.image),
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.topCenter,
                ),
              ),
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
                      padding: EdgeInsets.fromLTRB(
                          0.0,
                          max(MediaQuery.of(context).size.width * 0.225, 225),
                          0.0,
                          0.0),
                      child: Container(
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
                                height: 20,
                              ),
                              //in this row you find author and published date
                              Row(
                                children: [
                                  Icon(Icons.person),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    width: 200,
                                    child: ResponsiveGridRow(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: caseItem.author.map((author) {
                                        return ResponsiveGridCol(
                                            xl: 12,
                                            md: 12,
                                            xs: 12,
                                            child: Container(
                                              child: Text(
                                                author,
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ));
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(Icons.date_range),
                                  Text(caseItem.publishedDate)
                                ],
                              ),

                              Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text(
                                  caseItem.introduction,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //this is the description of the case. the main text
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Column(
                                  children: caseItem.description.map((item) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    );
                                  }).toList(),
                                ),
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
