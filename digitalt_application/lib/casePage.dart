import 'package:digitalt_application/caseItem.dart';
import 'package:digitalt_application/homePage.dart';
import 'package:flutter/material.dart';

class CasePage extends StatelessWidget {
  final CaseItem caseItem;

  CasePage({Key key, @required this.caseItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this is the appbar for the home page
      appBar: AppBar(
          backgroundColor: Colors.grey[600],
          elevation: 0,
          title: Text("Home"),
          actions: <Widget>[
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
          ]),
      //creates the menu in the appbar(drawer)
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      //here starts the body
      body: Container(
        //this is the backgound image of the case
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(caseItem.image),
            fit: BoxFit.contain,
            alignment: FractionalOffset.topCenter,
          ),
        ),
        //here starts the case
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
                padding: EdgeInsets.fromLTRB(0.0, 220.0, 0.0, 0.0),
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
      ),
    );
  }
}
