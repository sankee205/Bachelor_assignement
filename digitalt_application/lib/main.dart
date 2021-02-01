import 'package:flutter/material.dart';

void main() {
  // calls the class HomePage to run
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePage_State createState() => HomePage_State();
}

// this class represents a home page with a grid layout
class HomePage_State extends State<HomePage> {
  //list of pictures for the grid
  final List<String> _listItem = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    //returns a material design
    return Scaffold(
        //this is the appbar for the home page
        appBar: AppBar(
            backgroundColor: Colors.grey[600],
            elevation: 0,
            leading: Icon(
              Icons.menu,
              color: Colors.black,
            ),
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

        //here comes the body of the home page, includes the grid
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),

              //container for the upper image
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/4.jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(.4),
                          Colors.black.withOpacity(.2)
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //Expands a gridview for the image listet below the upper image
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: _listItem
                    .map((item) => Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(item),
                                    fit: BoxFit.cover)),
                          ),
                        ))
                    .toList(),
              ))
            ],
          ),
        )));
  }
}
