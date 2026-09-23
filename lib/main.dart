import 'package:flutter/material.dart';
import 'package:medicaldirectory/all_news.dart';
import 'package:medicaldirectory/bysearch.dart';
import 'package:medicaldirectory/categories.dart';
import 'package:medicaldirectory/company.dart';
import 'package:medicaldirectory/login.dart';
import 'package:medicaldirectory/news.dart';
import 'package:medicaldirectory/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/company_': (context) => const Company(),
        '/news_': (context) => const news(),
        '/search_': (context) => const bysearch()
      },
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

  List<dynamic> promos = [];
  List<dynamic> classifieds = [];
  List<dynamic> companies = [];
  List<dynamic> dbnews = [];

  TextEditingController what_controller = TextEditingController();
  TextEditingController where_controller = TextEditingController();

  String data = "Fetching data...";

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchData2();
    fetchData3();
    fetchData4();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://cdn.adslive.com/medpromos'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        promos = jsonData;
      });
    } else {
      setState(() {
        promos = [];
      });
    }
  }

  Future<void> fetchData2() async {
    final response =
        await http.get(Uri.parse('https://cdn.adslive.com/med_classifieds1'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        classifieds = jsonData;
        // print(classifieds);
      });
    } else {
      setState(() {
        classifieds = [];
        // print("no classifeds");
      });
    }
  }

  Future<void> fetchData3() async {
    final response = await http
        .get(Uri.parse('https://cdn.adslive.com/featured_med_comps1'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        companies = jsonData;
      });
    } else {
      setState(() {
        companies = [];
      });
    }
  }

  Future<void> fetchData4() async {
    final response =
        await http.get(Uri.parse('https://cdn.adslive.com/medNews5'));

    if (response.statusCode == 200) {
      final jsonData4 = json.decode(response.body);
      setState(() {
        dbnews = jsonData4;
        // print(dbnews);
      });
    } else {
      setState(() {
        dbnews = [];
        // print("no news");
      });
    }
  }

  void _showDialog(BuildContext context, text_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('System Message'),
            content: Text(text_),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        });
  }

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
              Text(""),
              Text(""),
              Row(children: [
                Text(" "),
                GestureDetector(
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          )
                        },
                    child: Row(children: [
                      Text("   "),
                      Image.asset(
                        'assets/logo.jpg',
                        height: 37,
                      )
                    ])),
                Spacer(),
                GestureDetector(
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          )
                        },
                    child: Icon(
                      Icons.dehaze,
                      color: Color.fromARGB(255, 5, 82, 119),
                      size: 40,
                    )),
                Text(" ")
              ]),
              Container(
                  width: double.infinity, // Set the width of the container
                  height: 80, // Set the height of the container
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
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Text(" "),
                            textBox1(context, what_controller),
                            Text(" "),
                            textBox2(context, where_controller),
                            Text(" "),
                            button(context, what_controller, where_controller,
                                _showDialog)
                          ],
                        ),
                      ),
                    ],
                  )),
              Text(""),
              Container(
                height: 550,
                width: double.infinity,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                        width: 300,
                        height: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 218, 217, 217)),
                          // color: Color.fromARGB(255, 5, 82, 119),
                          // borderRadius: BorderRadius.circular(
                          //     0.0),
                        ),
                        child: promos.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                scrollDirection: Axis
                                    .horizontal, // Change scroll direction to horizontal
                                itemCount: promos.length,
                                itemBuilder: (context, index) {
                                  return Row(children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/company_', arguments: {
                                            'company_id':
                                                '${promos[index]["company_id"]}',
                                            'url': '${promos[index]["url"]}'
                                          });
                                        },
                                        child: Image.network(
                                          'https://cdn.adslive.com/${promos[index]["url"]}',
                                          // width: 300,
                                          height: 150,
                                        )),
                                    Text(" ")
                                  ]);
                                },
                              )),
                    Text(""),
                    Row(children: [
                      Spacer(),
                      cat(context, "Hospitals", Icons.account_balance),
                      Text("   "),
                      cat(context, "Diagnostics", Icons.donut_large),
                      Text("   "),
                      cat(context, "Wellness", Icons.local_hospital),
                      Text("   "),
                      cat(context, "Nutrition", Icons.cake),
                      Text("   "),
                      cat(context, "Surgery", Icons.accessible),
                      Spacer()
                    ]),
                    Row(children: [
                      Spacer(),
                      cat(context, "Pharmacy", Icons.enhanced_encryption),
                      Text("   "),
                      cat(context, "Rehabs", Icons.local_florist),
                      Text("   "),
                      cat(context, "Cardiology", Icons.favorite_border),
                      Text("   "),
                      cat(context, "Clinics", Icons.description),
                      Text("   "),
                      cat(context, "Centers", Icons.local_hotel),
                      Spacer()
                    ]),
                    Text(""),
                    title_(context, Icons.home, " Featured Classified"),
                    Text(""),
                    Container(
                        width: 300,
                        height: 120,
                        child: classifieds.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                scrollDirection: Axis
                                    .horizontal, // Change scroll direction to horizontal
                                itemCount: classifieds.length,
                                itemBuilder: (context, index) {
                                  return Row(children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/company_',
                                              arguments: {
                                                'company_id':
                                                    '${classifieds[index]["company_id"]}',
                                                'url':
                                                    '${classifieds[index]["url"]}'
                                              });
                                        },
                                        child: Container(
                                            child: Image.network(
                                              'https://cdn.adslive.com/${classifieds[index]["url"]}',
                                              height: 150,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              // color: Color.fromARGB(255, 5, 82, 119),
                                              // borderRadius: BorderRadius.circular(
                                              //     0.0),
                                            ))),
                                    Text(" ")
                                  ]);
                                },
                              )),
                    Text(""),
                    title_(context, Icons.home, " Featured Listings"),
                    Container(
                        height: 150,
                        width: double.infinity,
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 218, 217, 217)),
                        ),
                        child: companies.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                scrollDirection: Axis
                                    .vertical, // Change scroll direction to horizontal
                                itemCount: companies.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/company_',
                                                arguments: {
                                                  'company_id':
                                                      '${companies[index]["id"]}',
                                                  'url':
                                                      '${companies[index]["logos"]}'
                                                });
                                          },
                                          child: row_2(
                                              context,
                                              "${companies[index]["logos"]}",
                                              "${companies[index]["name"]}",
                                              "${companies[index]["telephone"]}",
                                              "${companies[index]["address"]}")));
                                },
                              )),
                    Text(""),
                    title_(context, Icons.language, "Featured News"),
                    Container(
                        height: 150,
                        width: 400,
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 218, 217, 217)),
                        ),
                        child: dbnews.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                scrollDirection: Axis
                                    .vertical, // Change scroll direction to horizontal
                                itemCount: dbnews.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/news_',
                                            arguments: {
                                              'title':
                                                  '${dbnews[index]["title"]}',
                                              'body':
                                                  '${dbnews[index]["body"]}',
                                              'time':
                                                  '${dbnews[index]["time"]}',
                                              'image':
                                                  '${dbnews[index]["image"]}',
                                            });
                                      },
                                      child: news_row2(
                                          context,
                                          "${dbnews[index]["image"]}",
                                          "${dbnews[index]["title"]}",
                                          "${dbnews[index]["body"]}",
                                          "${dbnews[index]["time"]}"));
                                },
                              )),
                    // Container(
                    //     height: 150,
                    //     width: 400,
                    //     padding: EdgeInsets.all(20.0),
                    //     child: ListView(
                    //       children: <Widget>[
                    //         news_row(
                    //             context,
                    //             "assets/news1.jpg",
                    //             "Presidency Takes the Lead in Major Overhaul of State-Owned Enterprises",
                    //             "President Cyril Ramaphosa's office has taken charge of the overhaul of state-owned enterprises (SOEs), placing the responsibility on Maropene Ramokgopa, the minister of monitoring and evaluation.",
                    //             "17 Jul 2024"),
                    //         news_row(
                    //             context,
                    //             "assets/news1.jpg",
                    //             "Presidency Takes the Lead in Major Overhaul of State-Owned Enterprises",
                    //             "President Cyril Ramaphosa's office has taken charge of the overhaul of state-owned enterprises (SOEs), placing the responsibility on Maropene Ramokgopa, the minister of monitoring and evaluation.",
                    //             "17 Jul 2024"),
                    //         news_row(
                    //             context,
                    //             "assets/news1.jpg",
                    //             "Presidency Takes the Lead in Major Overhaul of State-Owned Enterprises",
                    //             "President Cyril Ramaphosa's office has taken charge of the overhaul of state-owned enterprises (SOEs), placing the responsibility on Maropene Ramokgopa, the minister of monitoring and evaluation.",
                    //             "17 Jul 2024"),
                    //         news_row(
                    //             context,
                    //             "assets/news1.jpg",
                    //             "Presidency Takes the Lead in Major Overhaul of State-Owned Enterprises",
                    //             "President Cyril Ramaphosa's office has taken charge of the overhaul of state-owned enterprises (SOEs), placing the responsibility on Maropene Ramokgopa, the minister of monitoring and evaluation.",
                    //             "17 Jul 2024"),
                    //       ],
                    //     )),
                  ],
                ),
              ),
            ])),
        bottomNavigationBar: footer(context)
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

Widget textBox1(BuildContext context, TextEditingController _controller) {
  return Container(
    width: 132, // Set the width of the container
    height: 37, // Set the height of the container
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      color: Colors.white, // Set the background color
      borderRadius: BorderRadius.circular(
          0.0), // Set the border radius to make corners rounded
    ),
    child: TextField(
      controller: _controller,
      style: TextStyle(color: Colors.grey), // Set the text color to grey
      decoration: InputDecoration(
        labelText: _controller.text.isEmpty ? ' What?' : null,
        labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(0.0),
        ),
        hintText: '',
      ),
      onChanged: (text) {
        if (text.isNotEmpty) {
          _controller.value = _controller.value.copyWith(
            text: text,
            selection: TextSelection.fromPosition(
              TextPosition(offset: text.length),
            ),
            composing: TextRange.empty,
          );
        }
      },
    ),
  );
}

Widget textBox2(context, TextEditingController _controller) {
  return Container(
    width: 132, // Set the width of the container
    height: 37, // Set the height of the container
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      color: Colors.white, // Set the background color
      borderRadius: BorderRadius.circular(
          0.0), // Set the border radius to make corners rounded
    ),
    child: TextField(
      controller: _controller,
      style: TextStyle(color: Colors.grey), // Set the text color to grey
      decoration: InputDecoration(
        labelText: _controller.text.isEmpty ? ' Where?' : null,
        labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(0.0),
        ),
        hintText: '',
      ),
      onChanged: (text) {
        if (text.isNotEmpty) {
          _controller.value = _controller.value.copyWith(
            text: text,
            selection: TextSelection.fromPosition(
              TextPosition(offset: text.length),
            ),
            composing: TextRange.empty,
          );
        }
      },
    ),
  );
}

Widget button(context, what, where, _showDialog) {
  return Container(
    width: 50, // 36 Set the width of the container
    height: 37, // Set the height of the container
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      color: Colors.white, // Set the background color
      borderRadius: BorderRadius.circular(
          0.0), // Set the border radius to make corners rounded
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero, // Remove default padding to ensure alignment
        primary: Colors
            .white, // Set the button background color to match the container
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(0.0), // Match the container border radius
        ),
      ),
      onPressed: () {
        if (what.text == "" || where.text == "") {
          // print('Searching: ${what.text}- ${where.text}');
          _showDialog(context, 'Please enter search details.');
        } else {
          Navigator.pushNamed(context, '/search_',
              arguments: {'what': '${what.text}', 'where': '${where.text}'});
        }
      },
      child: Icon(
        Icons.search,
        color: Colors.grey,
      ),
    ),
  );
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
      child: Text(
        " $text_",
        style: TextStyle(
          color: Colors.grey,
        ),
      ));
}

Widget cat(context, text_, icon_) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const categories()),
        );
      },
      child: Column(children: [
        Container(
            width: 40, // Set the width of the container
            height: 40, // Set the height of the container
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color:
                  Color.fromARGB(255, 5, 82, 119), // Set the background color
              borderRadius: BorderRadius.circular(
                  20.0), // Set the border radius to make corners rounded
            ),
            child: Icon(
              icon_,
              color: Colors.white,
            )),
        Text("$text_", style: TextStyle(fontSize: 12.0, color: Colors.grey))
      ]));
}

Widget title_(context, icon_, text_) {
  return Row(children: [
    Text("     "),
    Icon(icon_, color: Color.fromARGB(255, 5, 82, 119), size: 12),
    Text("$text_",
        style: TextStyle(
            fontSize: 12.0,
            color: Color.fromARGB(255, 5, 82, 119),
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
  return SizedBox(
      width: 500,
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // border color
                  width: 2, // border width
                ),
                borderRadius:
                    BorderRadius.circular(3), // optional: rounded corners
              ),
              child: Image.network(
                'https://cdn.adslive.com/$pic_',
                width: 60,
                height: 40,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.network(
                    'https://cdn.adslive.com/uploads/logos/placeholder/logo.png',
                    width: 60,
                    height: 40,
                  );
                },
              )),
          Text(" "),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              name_.length > 30 ? name_.substring(0, 30) : name_,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Color.fromARGB(255, 5, 82, 119)),
            ),
            Text(
              number_.length > 20 ? number_.substring(0, 20) : number_,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey),
            ),
            Text(
              address_.length > 30 ? address_.substring(0, 30) : address_,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey),
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
      ));
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
          " $article".substring(0, 35),
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
          width: 60,
          height: 40,
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Colors.black, // border color
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
                  MaterialPageRoute(builder: (context) => const categories()),
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
                  MaterialPageRoute(builder: (context) => const Search()),
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
                  MaterialPageRoute(builder: (context) => const login()),
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
