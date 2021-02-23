import 'package:digitalt_application/Permanent%20services/BaseAppBar.dart';
import 'package:digitalt_application/Permanent%20services/BaseAppDrawer.dart';
import 'package:digitalt_application/Permanent%20services/BaseBottomAppBar.dart';
import 'package:digitalt_application/Permanent%20services/BaseCarouselSlider.dart';
import 'package:digitalt_application/Permanent%20services/BaseCaseBox.dart';
import 'package:digitalt_application/Permanent%20services/BaseCaseItem.dart';
import 'package:digitalt_application/Permanent%20services/ExampleCases.dart';
import 'package:digitalt_application/casePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_grid/responsive_grid.dart';

/*
 * This is the main page of the flutter application and this is the window that will
 * open when you open the app. At the top it has an appbar with a drawer, then below 
 * the appbar a slider for newest/top X images, and at the end a gridview for all 
 * images in the list of items; _listItem.
 * 
 * @Sander Keedklang
 * 
 */

//creates a stateful widget
class HomePage extends StatefulWidget {
  ExampleCases exampleCases = new ExampleCases();
  @override
  HomePageState createState() => HomePageState();
}

// this class represents a home page with a grid layout
class HomePageState extends State<HomePage> {
  //example list for the grid layout

  @override
  Widget build(BuildContext context) {
    //returns a material design
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
          child: Center(
        child: Container(
          width: 800,
          color: Colors.grey.shade300,
          child: Column(
            children: [
              ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                    lg: 8,
                    xs: 12,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Colors.white),
                            height: 320,
                            child: ListView(
                              children: <Widget>[
                                //should we add a play and stop button?
                                BaseCarouselSlider(
                                    widget.exampleCases.popularCases)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 4,
                    xs: 12,
                    child: Container(
                      height: 325,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Siste Nytt',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: widget.exampleCases.sisteNyttList
                                  .map((caseObject) {
                                return Builder(builder: (
                                  BuildContext context,
                                ) {
                                  //makes the onclick available
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CasePage(
                                                      caseItem: caseObject,
                                                    )));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 500,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                  spreadRadius: 5)
                                            ]),
                                        margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          caseObject.title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ));
                                });
                              }).toList(),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              ResponsiveGridRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.exampleCases.caseList.map((e) {
                  return ResponsiveGridCol(
                      lg: 4,
                      md: 6,
                      xs: 12,
                      child: Container(
                          margin: EdgeInsets.all(5),
                          height: 250,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CasePage(
                                              caseItem: e,
                                            )));
                              },
                              child: BaseCaseBox(e))));
                }).toList(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
