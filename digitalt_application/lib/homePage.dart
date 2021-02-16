import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalt_application/caseItem.dart';
import 'package:digitalt_application/casePage.dart';
import 'package:digitalt_application/infoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  @override
  HomePageState createState() => HomePageState();
}

// this class represents a home page with a grid layout
class HomePageState extends State<HomePage> {
  //example list for the grid layout
  List<CaseItem> caseList = [
    CaseItem(
        image: 'assets/images/1.jpg',
        title: 'Flower',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description: 'This is a beautiful flower'),
    CaseItem(
        image: 'assets/images/2.jpg',
        title: 'Stones',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description: 'This is a beautiful Stone'),
    CaseItem(
        image: 'assets/images/3.jpg',
        title: 'Butterflies',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description: 'This is some beautiful butterflies'),
    CaseItem(
        image: 'assets/images/4.jpg',
        title: 'Sunset',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description: 'This is a beautiful sunset'),
    CaseItem(
        image: 'assets/images/5.jpg',
        title: 'Bubbles',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description: 'This is some beautiful bubbles'),
    CaseItem(
        image: 'assets/images/6.jpg',
        title: 'Swan',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description: 'This is a beautiful swan'),
  ];

  // example list for the carousel slider
  List<CaseItem> popularCases = [
    CaseItem(
        image: 'assets/images/2.jpg',
        title: 'Stones',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description:
            'This is a beautiful Stone. Adam Jones is one of rocks most talented and sonically innovative guitarists, from multi-platinum selling and multiple Grammy Award® winning band Tool. This limited-edition Gibson Custom Shop model recreates Adams #1 guitar - his prized original Silverburst 1979 Gibson Les Paul™ Custom. Finished in Antique Silverburst VOS, the graphic on the rear of the headstock was designed by Adam Jones, and a replica of his headstock mirror is included in the custom Adam Jones hardshell case. These guitars were hand-made by the expert luthiers and craftspeople of the Gibson Custom Shop as part of a very special run. This is a beautiful Stone. Adam Jones is one of rocks most talented and sonically innovative guitarists, from multi-platinum selling and multiple Grammy Award® winning band Tool. This limited-edition Gibson Custom Shop model recreates Adams #1 guitar - his prized original Silverburst 1979 Gibson Les Paul™ Custom. Finished in Antique Silverburst VOS, the graphic on the rear of the headstock was designed by Adam Jones, and a replica of his headstock mirror is included in the custom Adam Jones hardshell case. These guitars were hand-made by the expert luthiers and craftspeople of the Gibson Custom Shop as part of a very special run.'),
    CaseItem(
        image: 'assets/images/3.jpg',
        title: 'Butterflies',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description: 'This is some beautiful butterflies'),
    CaseItem(
        image: 'assets/images/5.jpg',
        title: 'Bubbles',
        author: 'Heidi Gundersen',
        publishedDate: '12.01.2021',
        description: 'This is some beautiful bubbles'),
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InfoPage()));
                },
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

        //here comes the body of the home page
        body: SafeArea(
            child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                ),
                height: 300,
                child: ListView(
                  children: <Widget>[
                    //should we add a play and stop button?
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 300,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          aspectRatio: 0.25,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayInterval: Duration(seconds: 10),
                          viewportFraction: 0.8,
                          initialPage: 0),
                      items: popularCases.map((caseitem) {
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
                                            caseItem: caseitem,
                                          )));
                            },
                            child: Container(
                              width: 400,
                              height: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(caseitem.image),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                        spreadRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    caseitem.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                      }).toList(),
                    ),
                  ],
                ),
              ),

              //Expands a gridview for the image listet below the slider above
              Container(
                child: Expanded(
                  child: Container(
                      width: 600,
                      child: GridView.count(
                        padding: EdgeInsets.all(20),
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: caseList
                            .map((caseitems) => Card(
                                color: Colors.transparent,
                                elevation: 0,
                                //makes the onclick available
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CasePage(
                                                  caseItem: caseitems,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: AssetImage(caseitems.image),
                                            fit: BoxFit.cover),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 7,
                                              offset: Offset(0, 3),
                                              spreadRadius: 5)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          caseitems.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )))
                            .toList(),
                      )),
                ),
              )
            ],
          ),
        )));
  }
}
