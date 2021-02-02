import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/**
 * This is the main page of the flutter application and this is the window that will
 * open when you open the app. At the top it has an appbar with a drawer, then below 
 * the appbar a slider for newest/top X images, and at the end a gridview for all 
 * images in the list of items; _listItem.
 * 
 * @Sander Keedklang
 */
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
            children: const <Widget>[
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

        //here comes the body of the home page
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
                child: ListView(
                  children: <Widget>[
                    //this is the slider at the top of the homepage
                    CarouselSlider(
                      height: 180,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      aspectRatio: 0.25,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayInterval: Duration(seconds: 10),
                      viewportFraction: 0.8,
                      items: _listItem.map((item) {
                        return Builder(builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(item),
                                    fit: BoxFit.cover)),
                          );
                        });
                      }).toList(),
                    ),
                  ],
                ),
              ),

              //Expands a gridview for the image listet below the slider above
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
