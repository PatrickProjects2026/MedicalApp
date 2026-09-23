// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:medicaldirectory/all_news.dart';
import 'package:medicaldirectory/categories.dart';
import 'package:medicaldirectory/login.dart';
import 'package:medicaldirectory/main.dart';
import 'package:medicaldirectory/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:js_util' as js_util;
// import 'dart:js';

void main() {
  runApp(const news());
}

String title = "";
String body = "";
String image = "";
String time = "";

String company_id = "";
String address = "";
String telephone = "";
String name = "";
String banner = "uploads/viewpage_banners/placeholder/viewpage.png";
String logo = "uploads/logos/placeholder/logo.png";

class news extends StatelessWidget {
  const news({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    title = args['title'];
    body = args['body'];
    time = args['time'];
    image = args['image'];

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF673AB7)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // List<dynamic> company = [];
  Map<String, dynamic> company = {};

  TextEditingController _controller = TextEditingController();

  String data = "Fetching data...";

  @override
  void initState() {
    super.initState();
    // fetchData();
    // viewpageBanner();
  }

  // Future<void> fetchData() async {
  //   final response = await http
  //       .get(Uri.parse('https://cdn.adslive.com/get_company/${company_id}'));

  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     setState(() {
  //       company = jsonData[0];
  //       // print(company);

  //       if (company['logos'] != "null") {
  //         logo = company['logos'];
  //       }

  //       if (company['name'].length >= 30) {
  //         name = company['name'].substring(0, 30);
  //       } else {
  //         name = company['name'];
  //       }

  //       if (company['address'].length >= 40) {
  //         address = company['address'].substring(0, 40);
  //       } else {
  //         address = company['address'];
  //       }

  //       if (company['telephone'].length >= 30) {
  //         telephone = company['telephone'].substring(0, 30);
  //       } else {
  //         telephone = company['telephone'];
  //       }
  //     });
  //   } else {
  //     setState(() {
  //       // company = [];
  //       company = {};
  //       // print("no data");
  //     });
  //   }
  // }

  // Future<void> viewpageBanner() async {
  //   final response = await http.get(
  //       Uri.parse('https://cdn.adslive.com/viewpage_banner/${company_id}'));

  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     setState(() {
  //       banner = jsonData[0]['url'];
  //       // print(company);
  //     });
  //   } else {
  //     setState(() {
  //       // company = [];
  //       banner = "uploads/viewpage_banners/placeholder/viewpage.png";
  //       // print("no data");
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //

    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                //
                // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                // action in the IDE, or press "p" in the console), to see the
                // wireframe for each widget.
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                  width: 900, // Set the width of the container
                  height: 60, // Set the height of the container
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color.fromARGB(
                        255, 5, 82, 119), // Set the background color
                    borderRadius: BorderRadius.circular(
                        0.0), // Set the border radius to make corners rounded
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                },
                                icon: Icon(
                                  Icons.dehaze,
                                  color: Colors.white,
                                  size: 20,
                                )),
                            Text("Detailed View",
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  )),
              Text(""),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const allnews()),
                    );
                  },
                  child: Row(children: [
                    Text(" "),
                    Icon(Icons.arrow_back,
                        color: Color.fromARGB(255, 5, 82, 119))
                  ])),
              Text(""),
              Row(
                children: [
                  Spacer(),
                  SizedBox(
                    width: 300, // Set the width of the SizedBox
                    child: Text(
                      '$title',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: Color.fromARGB(255, 5, 82, 119)),
                    ),
                  ),
                  Spacer()
                ],
              ),
              Container(
                height: 550,
                child: Flexible(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Container(
                              // height: 2800,
                              width: double.infinity,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Spacer(),
                                    Image.network(
                                      image,
                                      width: 310,
                                    ),
                                    Spacer()
                                  ],
                                ),
                                Text(""),
                                Text(
                                  '$time',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.black),
                                ),
                                Text(""),
                                SizedBox(
                                  width: 300, // Set the width of the SizedBox
                                  child: Text(
                                    '$body',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black),
                                  ),
                                ),
                              ])))),
                ),
              ),
              Spacer()
            ])),
        bottomNavigationBar: footer(context)
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

Widget row1(context, field_, data_) {
  return Row(children: [
    Text("   "),
    Container(
        width: 85,
        child: Text(
          " ${field_}",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),
        )),
    Text("    "),
    SizedBox(
      width: 240, // Set the width of the SizedBox
      child: Text(
        ' ${data_}',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Color.fromARGB(255, 5, 82, 119)),
      ),
    ),
    // Text(
    //   " ${data_}",
    //   textAlign: TextAlign.left,
    //   style: TextStyle(
    //       fontWeight: FontWeight.bold, fontSize: 11, color: Color.fromARGB(255, 5, 82, 119)),
    // ),
  ]);
}

Widget textBox(context, text_) {
  return Container(
      width: 135, // Set the width of the container
      height: 25, // Set the height of the container
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white, // Set the background color
        borderRadius: BorderRadius.circular(
            0.0), // Set the border radius to make corners rounded
      ),
      child: Text(" $text_"));
}

Widget button(context) {
  return Container(
      width: 100, // Set the width of the container
      height: 25, // Set the height of the container
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Color.fromARGB(255, 5, 82, 119), // Set the background color
        borderRadius: BorderRadius.circular(
            0.0), // Set the border radius to make corners rounded
      ),
      child: Text("Details",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white)));
}

Widget cat(context, text_, icon_) {
  return Column(children: [
    Container(
        width: 40, // Set the width of the container
        height: 40, // Set the height of the container
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Color.fromARGB(255, 5, 82, 119), // Set the background color
          borderRadius: BorderRadius.circular(
              20.0), // Set the border radius to make corners rounded
        ),
        child: Icon(
          icon_,
          color: Colors.white,
        )),
    Text("$text_", style: TextStyle(fontSize: 12.0, color: Colors.black))
  ]);
}

Widget title_(context, icon_, text_) {
  return Row(children: [
    Text("     "),
    Icon(icon_, color: Color.fromARGB(255, 5, 82, 119), size: 12),
    Text("$text_",
        style: TextStyle(
            fontSize: 12.0,
            color: Color.fromARGB(255, 29, 88, 67),
            fontWeight: FontWeight.bold))
  ]);
}

Widget row_(context, pic_, name_, number_, address_) {
  return Row(
    children: [
      Container(
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // border color
              width: 2, // border width
            ),
            borderRadius: BorderRadius.circular(3), // optional: rounded corners
          ),
          child: Image.asset(
            pic_,
            width: 60,
            height: 40,
          )),
      Text(" "),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          " $name_",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Color.fromARGB(255, 5, 82, 119)),
        ),
        Text(
          " $number_\n $address_",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 10, color: Colors.grey),
        ),
      ]),
      Spacer(),
      Icon(
        Icons.more_vert,
        size: 35,
        color: Color.fromARGB(255, 5, 82, 119),
      )

      // Text(
      //   number_,
      //   style: TextStyle(
      //       fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),
      // )
    ],
  );
}

Widget row_2(context, pic_, name_, number_, address_) {
  return Row(
    children: [
      Container(
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // border color
              width: 2, // border width
            ),
            borderRadius: BorderRadius.circular(3), // optional: rounded corners
          ),
          child: Image.network(
            'https://cdn.adslive.com/$pic_',
            width: 60,
            height: 40,
          )),
      Text(" "),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          " $name_",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Color.fromARGB(255, 5, 82, 119)),
        ),
        Text(
          " $number_",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 10, color: Colors.grey),
        ),
        Text(
          " $address_".substring(0, 30),
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 10, color: Colors.grey),
        )
      ]),
      Spacer(),
      Icon(
        Icons.more_vert,
        size: 35,
        color: Color.fromARGB(255, 5, 82, 119),
      )

      // Text(
      //   number_,
      //   style: TextStyle(
      //       fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),
      // )
    ],
  );
}

Widget news_row(context, pic_, header, article, date) {
  return Row(
    children: [
      Text(" "),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          " $header ".substring(0, 30),
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Color.fromARGB(255, 5, 82, 119)),
        ),
        Text(
          " $article".substring(0, 40),
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        Text(
          " $date",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Color.fromARGB(255, 99, 97, 97)),
        )
      ]),
      Spacer(),
      Container(
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // border color
              width: 2, // border width
            ),
            borderRadius: BorderRadius.circular(3), // optional: rounded corners
          ),
          child: Image.asset(
            pic_,
            width: 60,
            height: 40,
          ))
    ],
  );
}

Widget news_row2(context, pic_, header, article, date) {
  return Row(
    children: [
      Text(" "),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          " $header ".substring(0, 30),
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Color.fromARGB(255, 5, 82, 119)),
        ),
        Text(
          " $article".substring(0, 40),
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        Text(
          " $date",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Color.fromARGB(255, 99, 97, 97)),
        )
      ]),
      Spacer(),
      Container(
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // border color
              width: 2, // border width
            ),
            borderRadius: BorderRadius.circular(3), // optional: rounded corners
          ),
          child: Image.network(
            pic_,
            width: 60,
            height: 40,
          ))
    ],
  );
}

Widget footer(context) {
  return BottomAppBar(
    color: Color.fromARGB(255, 5, 82, 119),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => allnews()),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.public, color: Colors.white),
                  Text("News",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              )),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => categories()),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.receipt, color: Colors.white),
                  Text("Categories",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              )),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.home, color: Colors.white),
                  Text("Home",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              )),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Search()),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.search, color: Colors.white),
                  Text("Search",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              )),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.power_settings_new, color: Colors.white),
                  Text("Login",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ))
        ],
      ),
    ),
  );
}
