// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:medicaldirectory/all_news.dart';
import 'package:medicaldirectory/categories.dart';
import 'package:medicaldirectory/contact.dart';
import 'package:medicaldirectory/login.dart';
import 'package:medicaldirectory/main.dart';
import 'package:medicaldirectory/news.dart';
import 'package:medicaldirectory/profile.dart';
import 'package:medicaldirectory/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'dart:js_util' as js_util;
// import 'dart:js';

void main() {
  runApp(const Company());
}

String banner = "uploads/viewpage_banners/placeholder/viewpage.png";
String logo = "uploads/logos/placeholder/logo.png";
String advert = "uploads/logos/placeholder/logo.png";
String url = "";

String passit = "";
String companyid = "";
String name = "";
String address = "";
String telephone = "";
String email = "";
String aboutus = "";
String country = "";
String province = "";
String city = "";

String registerMsg = "";

String _sessionData = "No session data";
String from_page = "";

Map<String, dynamic> company = {};

class Company extends StatelessWidget {
  const Company({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // if (args['cid'] != null) {
    //   companyid = args['cid'];
    // } else {
    //   companyid = args['company_id'];
    // }
    from_page = args['from_page'] ?? "";
    print("From:$from_page");

    passit = args['passit'] ?? "";
    companyid = args['company_id'];
    url = args['url'] ?? logo;
    name = args['name'] ?? "";
    address = args['address'] ?? "";
    telephone = args['telephone'] ?? "";
    email = args['email'] ?? "";
    aboutus = args['about_us'] ?? "Welcome to $name.";
    country = args['country'] ?? "";
    province = args['province'] ?? "";
    city = args['city'] ?? "";

    company['id'] = companyid;
    company['company_id'] = companyid;
    company['name'] = name;
    company['email'] = email;
    company['telephone'] = telephone;
    company['about_us'] = aboutus;
    company['country'] = country;
    company['province'] = province;
    company['city'] = city;

    company['facebook'] = "";
    company['twitter'] = "";
    company['youtube'] = "";
    company['skype'] = "";

    print("Passit:{$passit}  {$url}  {$name}  {$address}   {$telephone}");
    // print("----variables-------$companyid--------$url------");

    return MaterialApp(
      routes: {
        '/contact_': (context) => const Contact(),
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

  // List<dynamic> company = [];
  // Map<String, dynamic> company = {};

  TextEditingController _controller = TextEditingController();
  TextEditingController name_ = TextEditingController();
  TextEditingController email_ = TextEditingController();
  TextEditingController message_ = TextEditingController();

  String data = "Fetching data...";

  @override
  void initState() {
    super.initState();
    fetchData();
    viewpageBanner();
    full_advert();
    _loadSessionData();
  }

  void _loadSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _sessionData = prefs.getString('sessionData') ?? "No session data";
    });
  }

  // Save session data to SharedPreferences
  void _saveSessionData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessionData', data);
    _loadSessionData();
  }

  // Clear session data
  void _clearSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionData');
    _loadSessionData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://cdn.adslive.com/get_company/${companyid}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        company = jsonData[0];
        // print(company);

        if (company['logos'] != "null") {
          logo = company['logos'];
        } else {
          // logo = "uploads/logos/placeholder/logo.png";
        }

        if (company['name'].length >= 30) {
          name = company['name'].substring(0, 30);
        } else {
          name = company['name'];
        }

        if (company['address'].length >= 40) {
          address = company['address'].substring(0, 40);
        } else if (company['address'].length < 40) {
          address = company['address'] ?? address;
        }

        if (company['telephone'].length >= 30) {
          telephone = company['telephone'].substring(0, 30);
        } else {
          telephone = company['telephone'] ?? telephone;
        }
      });
    } else {
      setState(() {
        // company = [];
        logo = "uploads/logos/placeholder/logo.png";

        // company = {
        //   "name": name,
        //   "address": address,
        //   "telephone": telephone,
        //   "email": email,
        //   "about_us": aboutus,
        //   "country":
        //       (country != "" && country.isNotEmpty) ? country : "South Africa",
        //   "province": province,
        //   "city": city
        // };
        // print("no data");
      });
    }
  }

  Future<String> logoUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return url;
    } catch (e) {
      return "https://cdn.adslive.com/uploads/logos/placeholder/logo.png";
    }
  }

  Future<void> viewpageBanner() async {
    final response = await http
        .get(Uri.parse('https://cdn.adslive.com/viewpage_banner/${companyid}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        banner = jsonData[0]['url'];
        // print(company);
      });
    } else {
      setState(() {
        // company = [];
        banner = "uploads/viewpage_banners/placeholder/viewpage.png";
        // print("no data");
      });
    }
  }

  Future<void> full_advert() async {
    final response = await http
        .get(Uri.parse('https://cdn.adslive.com/full_advert/${companyid}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        advert = jsonData[0]['url'];
        // print(company);
      });
    } else {
      setState(() {
        // company = [];
        advert = "uploads/viewpage_banners/placeholder/logo.png";
        // print("no data");
      });
    }
  }

  void _showDialog(BuildContext context, text_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text('System Message'),
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

  void _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  void _launchUrl(String url) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      path: url,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  Future<void> _addFavorite(uid, cid) async {
    final response = await http
        .get(Uri.parse('https://cdn.adslive.com/add_fav/${uid}/${cid}'));

    if (response.statusCode == 200) {
      // final jsonData = json.decode(response.body);
      print("Response:${response.body}");
      registerMsg = response.body;
    }
  }

  // Void function for navigation
  void navigateToPage0(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void navigateToPage(BuildContext? context, String fromPage) {
    if (context == null) {
      print("No context available for navigation.");
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (fromPage) {
        case "profile":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Profile()),
          );
          break;
        case "search":
        default:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Search()),
          );
          break;
      }
    });
  }

  void navigateBasedOnPage(dynamic from_page) {
    // if (from_page is String) {
    //   navigateToPage(context, from_page);
    // } else {
    //   _showDialog(context, "Failed to navigate: $from_page");

    //   // If from_page is not a String, we can't handle it, so we assume default navigation
    //   if (from_page is Map<String, dynamic>) {
    //     // Optional: Handle Map<String, dynamic> case if needed
    //   } else {
    // Handle the default navigation case
    switch (from_page.toString()) {
      case "profile":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
        break;
      case "search":
      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Search()),
        );
        break;
    }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //

    String addrezz = address.length > 40 ? address.substring(0, 40) : address;
    String namez = name.length > 35 ? name.substring(0, 35) : name;
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
                            Text("Company  ",
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.white)),
                            // Icon(
                            //   Icons.person,
                            //   color: Colors.white,
                            //   size: 20,
                            // ),
                            // Icon(
                            //   Icons.notifications,
                            //   color: Colors.white,
                            //   size: 20,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Text(""),
              GestureDetector(
                  onTap: () {
                    print("Search FromPage:$from_page");

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Search()),
                    );

                    // navigateBasedOnPage(from_page);

                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   navigateToPage(context, "profile");
                    // });

                    // if (from_page is Map<String, dynamic>) {
                    //   navigateToPage(this.context, from_page);
                    // } else {
                    //   _showDialog(context, "Failed to navigate:$from_page");
                    //   switch (from_page.toString()) {
                    //     case "profile":
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const Profile()),
                    //       );
                    //       break;
                    //     case "search":
                    //     default:
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const Search()),
                    //       );
                    //       break;
                    //   }
                    // }

                    // Widget page;

                    // switch (from_page) {
                    //   case "profile":
                    //     page = Profile();
                    //     break;
                    //   case "search":
                    //   default:
                    //     page = Search();
                    //     break;
                    // }

                    // Navigator.pop(context);

                    // if (from_page == "profile") {
                    //   print("going profile");
                    //   navigateToPage(context, const Profile());
                    // }

                    // if (from_page == "search") {
                    //   print("going to search");
                    //   navigateToPage(context, const Search());
                    // }
                  },
                  child: Row(children: [
                    Text("      "),
                    Icon(Icons.arrow_back,
                        color: Color.fromARGB(255, 5, 82, 119))
                  ])),
              Text(""),
              Row(
                children: [
                  Text("       "),
                  Container(
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        border: Border.all(
                          color: Colors.grey, // border color
                          width: 2, // border width
                        ),
                        borderRadius: BorderRadius.circular(
                            3), // optional: rounded corners
                      ),
                      child: Image.network(
                        'https://cdn.adslive.com/$logo',
                        width: 78,
                        height: 50,
                      )),
                  Text(""),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " $namez",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromARGB(255, 5, 82, 119)),
                        ),
                        Text(
                          " $addrezz",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: Colors.grey),
                        ),
                        GestureDetector(
                            onTap: () {
                              _launchPhone(telephone);
                            },
                            child: Text(
                              " $telephone",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Colors.grey),
                            ))
                      ])
                ],
              ),
              Text(""),
              Container(
                  height: 500,
                  width: 350,
                  child: DefaultTabController(
                      length: 4,
                      child: Column(children: [
                        TabBar(
                          tabs: [
                            button(context, "Details"),
                            button(context, "Contact"),
                            button(context, "Social"),
                            button(context, "Advert")
                          ],
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      height: 1000,
                                      width: double.infinity,
                                      child: TabBarView(
                                        children: [
                                          details_(context, company,
                                              _showDialog, _addFavorite),
                                          contact_(
                                              context,
                                              name_,
                                              email_ != "" ? email_ : email,
                                              message_,
                                              _showDialog,
                                              company),
                                          Column(children: [
                                            Text(""),
                                            social_(
                                                "Facebook",
                                                company['facebook'],
                                                Icon(Icons.facebook,
                                                    color: Color.fromARGB(
                                                        255, 5, 82, 119)),
                                                _launchUrl),
                                            Text(""),
                                            social_(
                                                "Twitter",
                                                company['twitter'],
                                                Icon(Icons.clear,
                                                    color: Color.fromARGB(
                                                        255, 5, 82, 119)),
                                                _launchUrl),
                                            Text(""),
                                            social_(
                                                "YouTube",
                                                company['youtube'],
                                                Icon(Icons.youtube_searched_for,
                                                    color: Color.fromARGB(
                                                        255, 5, 82, 119)),
                                                _launchUrl),
                                            Text(""),
                                            social_(
                                                "Linkedin",
                                                company['linkedin'],
                                                Icon(Icons.linked_camera,
                                                    color: Color.fromARGB(
                                                        255, 5, 82, 119)),
                                                _launchUrl),
                                            Text(""),
                                            social_(
                                                "Instagram",
                                                company['instagram'],
                                                Icon(Icons.install_desktop,
                                                    color: Color.fromARGB(
                                                        255, 5, 82, 119)),
                                                _launchUrl),
                                            Text(""),
                                            social_(
                                                "Skype",
                                                company['skype'],
                                                Icon(Icons.upload,
                                                    color: Color.fromARGB(
                                                        255, 5, 82, 119)),
                                                _launchUrl),
                                          ]),
                                          Column(children: [
                                            Text(""),
                                            Text(""),
                                            Container(
                                                margin: EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                  // color: Colors.grey,
                                                  border: Border.all(
                                                    color: Colors
                                                        .grey, // border color
                                                    width: 2, // border width
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3), // optional: rounded corners
                                                ),
                                                child: Image.network(
                                                  'https://cdn.adslive.com/$advert',
                                                  width: 320,
                                                ))
                                          ])
                                        ],
                                      ),
                                    ))))
                      ]))),
              Spacer()

              // tabs_(context)
            ])),
        bottomNavigationBar: footer(context)
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

Widget _backButton(context) {
  return GestureDetector(
      onTap: () {
        print("Search FromPage:$from_page");

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Search()),
        // );

        // switch (from_page) {
        //   case "profile":
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const Profile()),
        //     );
        //     break;
        //   case "search":
        //   default:
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const Search()),
        //     );
        //     break;
        // }

        // Widget page;

        // switch (from_page) {
        //   case "profile":
        //     page = Profile();
        //     break;
        //   case "search":
        //   default:
        //     page = Search();
        //     break;
        // }

        // Navigator.pop(context);

        // if (from_page == "profile") {
        //   print("going profile");
        //   navigateToPage(context, const Profile());
        // }

        // if (from_page == "search") {
        //   print("going to search");
        //   navigateToPage(context, const Search());
        // }
      },
      child: Row(children: [
        Text("      "),
        Icon(Icons.arrow_back, color: Color.fromARGB(255, 5, 82, 119))
      ]));
}

Widget details_(context, company, _showDialog, _addFavorite) {
  return Column(children: [
    Text(""),
    row2('Email', Icon(Icons.email, color: Color.fromARGB(255, 5, 82, 119)),
        company['email']),
    row2(
        'Adress',
        Icon(Icons.location_city, color: Color.fromARGB(255, 5, 82, 119)),
        company['address']),
    row2(
        'Country',
        Icon(Icons.language, color: Color.fromARGB(255, 5, 82, 119)),
        company['country']),
    row2(
        'Region',
        Icon(Icons.location_disabled, color: Color.fromARGB(255, 5, 82, 119)),
        company['region']),
    row2(
        'City',
        Icon(Icons.location_city, color: Color.fromARGB(255, 5, 82, 119)),
        company['city']),
    Text(""),
    Row(
      children: [
        Text("    "),
        SizedBox(
            width: 320, // Set the width of the SizedBox
            child: Text(
              "${company['about_us']}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey),
            ))
      ],
    ),
    Text("   "),
    GestureDetector(
        onTap: () {
          print("liking...");
          print("Session:$_sessionData");

          if (_sessionData == "No session data") {
            _showDialog(context, "Please login to add Favorites");
          } else {
            _addFavorite(_sessionData, company['id']);
            _showDialog(context, "Added to Favorites");
          }
        },
        child: Row(children: [
          Text("    Favorite",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color.fromARGB(255, 5, 82, 119))),
          Icon(Icons.favorite, color: Color.fromARGB(255, 5, 82, 119), size: 17)
        ])),
    Row(children: [
      Text("   "),
      Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            // color: Color.fromARGB(255, 5, 82, 119),
            // borderRadius: BorderRadius.circular(
            //     0.0),
          ),
          child: Image.network(
            'https://cdn.adslive.com/$banner',
            width: 320,
          )),
    ]),
  ]);
}

Widget contact_(context, name_, email_, message_, _showDialog, company) {
  return Column(children: [
    Text(""),
    Row(children: [
      Text("   "),
      Container(
          width: 80,
          child: Row(children: [
            Icon(
              Icons.verified_user,
              color: Color.fromARGB(255, 5, 82, 119),
            ),
            Text(
              "Name",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            )
          ])),
      Text("    "),
      Container(
          width: 225,
          height: 37,
          child: TextField(
            controller: name_,
            style: TextStyle(color: Colors.grey), // Set the text color to grey
            decoration: InputDecoration(
              labelText: "Your name",
              labelStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: '',
            ),
          ))
    ]),
    Text(""),
    Row(children: [
      Text("   "),
      Container(
          width: 80,
          child: Row(children: [
            Icon(
              Icons.email,
              color: Color.fromARGB(255, 5, 82, 119),
            ),
            Text(
              "Email",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            )
          ])),
      Text("    "),
      Container(
          width: 225,
          height: 37,
          child: TextField(
            controller: email_,
            style: TextStyle(color: Colors.grey), // Set the text color to grey
            decoration: InputDecoration(
              labelText: "Your email",
              labelStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: '',
            ),
          ))
    ]),
    Text(""),
    Row(children: [
      Text("   "),
      Container(
          width: 80,
          height: 50,
          child: Row(children: [
            Icon(
              Icons.note,
              color: Color.fromARGB(255, 5, 82, 119),
            ),
            Text(
              "Note",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            )
          ])),
      Text("    "),
      Container(
          width: 225,
          height: 50,
          child: TextField(
            controller: message_,
            style: TextStyle(color: Colors.grey), // Set the text color to grey
            decoration: InputDecoration(
              labelText: "Enter message here",
              labelStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: '',
            ),
          ))
    ]),
    Text(""),
    Row(children: [
      Text("   "),
      Container(width: 97, child: Text("")),
      Container(
          width: 225,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 5, 82, 119),
              foregroundColor: Colors.white,

              padding: EdgeInsets.all(
                  8), // Remove default padding to ensure alignment
              primary: Colors
                  .white, // Set the button background color to match the container
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    5.0), // Match the container border radius
              ),
            ),
            onPressed: () {
              print(
                  'Searching: ${name_.text}- ${email_.text} - ${message_.text}');
              // Navigator.pushNamed(context, '/search_', arguments: {
              //   'what': '${what.text}',
              //   'where': '${where.text}'
              // });

              if (name_.text == "" ||
                  email_.text == "" ||
                  message_.text == "") {
                _showDialog(context,
                    'Please enter your details to send the message to this company.');
              } else {
                print(
                    'Searching: ${name_.text}- ${email_.text} - ${message_.text}');
                // Navigator.pushNamed(context, '/search_', arguments: {
                //   'what': '${what.text}',
                //   'where': '${where.text}'
                // });

                _showDialog(context, 'Email sent to (${company['email']})');
              }
            },
            child: Row(
              children: [
                Spacer(),
                Text("Send Message"),
                Spacer(),
                Icon(Icons.send),
                Spacer()
              ],
            ),
          )),
    ]),
  ]);
}

Widget tabs_(context) {
  return Container(
      height: 100,
      child: DefaultTabController(
          length: 3, // Number of tabs
          child: Column(children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.search), text: 'Search'),
                Tab(icon: Icon(Icons.person), text: 'Profile'),
              ],
            ),
            TabBarView(
              children: [
                Center(child: Text('Home Tab')),
                Center(child: Text('Search Tab')),
                Center(child: Text('Profile Tab')),
              ],
            )
          ])));
}

Widget row2(field_, icon_, data_) {
  if (data_ != null && data_ != "") {
    return Row(children: [
      Text("   "),
      Container(
          width: 85,
          child: Row(children: [
            icon_,
            Text(
              " ${field_}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Colors.grey),
            )
          ])),
      Text("    "),
      SizedBox(
        width: 220, // Set the width of the SizedBox
        child: Text(
          '${data_}',
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: Color.fromARGB(255, 5, 82, 119)),
        ),
      ),
    ]);
  } else {
    return Container();
  }
}

Widget social_(field_, data_, icon_, _launchUrl) {
  if (data_ == null || data_ == "") {
    data_ = "Not Available";
  }

  return Row(children: [
    Text("   "),
    Container(
        width: 100,
        child: Row(children: [
          icon_,
          Text(
            " ${field_}",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),
          )
        ])),
    Text("    "),
    SizedBox(
        width: 220, // Set the width of the SizedBox
        child: GestureDetector(
          onTap: () {
            _launchUrl(data_);
          },
          child: Text(
            '${data_}',
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: Color.fromARGB(255, 5, 82, 119)),
          ),
        )),
  ]);
}

Widget row1(context, field_, data_) {
  if (data_ != null && data_ != "") {
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
          '${data_}',
          textAlign: TextAlign.justify,
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
  } else {
    return Container();
  }
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

Widget button(context, text_) {
  return Container(
      width: 120, // Set the width of the container
      height: 25, // Set the height of the container
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Color.fromARGB(255, 5, 82, 119), // Set the background color
        borderRadius: BorderRadius.circular(
            0.0), // Set the border radius to make corners rounded
      ),
      child: Text(text_,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white)));
}

Widget button1(context) {
  return Container(
      width: 110, // Set the width of the container
      height: 25, // Set the height of the container
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.grey, // Set the background color
        borderRadius: BorderRadius.circular(
            0.0), // Set the border radius to make corners rounded
      ),
      child: Text("Details",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white)));
}

Widget button2(context, id) {
  return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/contact_',
            arguments: {'company_id': '$id', 'url': ""});
      },
      child: Container(
          width: 110, // Set the width of the container
          height: 25, // Set the height of the container
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Color.fromARGB(255, 5, 82, 119), // Set the background color
            borderRadius: BorderRadius.circular(
                0.0), // Set the border radius to make corners rounded
          ),
          child: Text("Contact",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.white))));
}

Widget button3(context) {
  return Container(
      width: 110, // Set the width of the container
      height: 25, // Set the height of the container
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Color.fromARGB(255, 5, 82, 119), // Set the background color
        borderRadius: BorderRadius.circular(
            0.0), // Set the border radius to make corners rounded
      ),
      child: Text("Social",
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
