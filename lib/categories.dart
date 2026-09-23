import 'package:flutter/material.dart';
import 'package:medicaldirectory/all_news.dart';
import 'package:medicaldirectory/bycat.dart';
import 'package:medicaldirectory/company.dart';
import 'package:medicaldirectory/login.dart';
import 'package:medicaldirectory/main.dart';
import 'package:medicaldirectory/news.dart';
import 'package:medicaldirectory/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const categories());
}

class categories extends StatelessWidget {
  const categories({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/company_': (context) => const Company(),
        '/bycat_': (context) => const bycat()
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
  List<dynamic> db_news = [];

  TextEditingController _controller = TextEditingController();

  String data = "Fetching data...";

  @override
  void initState() {
    super.initState();

    fetchData3();
  }

  Future<void> fetchData3() async {
    final response =
        await http.get(Uri.parse('https://cdn.adslive.com/featured_comps'));

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
                            MaterialPageRoute(
                                builder: (context) => categories()),
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
                            Text("View all Categories",
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  )),
              // Text(""),
              Container(
                height: 550,
                width: double.infinity,
                padding: EdgeInsets.all(0.0),
                child: ListView(
                  children: <Widget>[
                    // Text(""),
                    // title_(context, Icons.home, "Search Companies "),
                    Container(
                        height: 550,
                        width: double.infinity,
                        padding: EdgeInsets.all(10.0),
                        child: ListView.builder(
                          scrollDirection: Axis
                              .vertical, // Change scroll direction to horizontal
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              Text(""),
                              getCat(context, "1", "Acupuncture"),
                              Divider(),
                              getCat(context, "2", "Allied "),
                              Divider(),
                              getCat(context, "3", "Alternative Health"),
                              Divider(),
                              getCat(context, "4", "Ambulance Services"),
                              Divider(),
                              getCat(context, "5", "Anaesthetists "),
                              Divider(),
                              getCat(context, "6", "Aquatic Therapist"),
                              Divider(),
                              getCat(context, "7", "Educational Institutions"),
                              Divider(),
                              getCat(context, "8", "Aromatherapy"),
                              Divider(),
                              getCat(context, "9", "Audiometric"),
                              Divider(),
                              getCat(context, "10", "Ayurveda Practitioner"),
                              Divider(),
                              getCat(context, "11", "Biokineticist"),
                              Divider(),
                              getCat(
                                  context, "12", "Cardiac & Thoracic Surgeon"),
                              Divider(),
                              getCat(context, "13", "Cardiologists"),
                              Divider(),
                              getCat(context, "14", "Chiropractors"),
                              Divider(),
                              getCat(context, "15", "General Clinics"),
                              Divider(),
                              getCat(context, "16", "Government Clinics"),
                              Divider(),
                              getCat(context, "17", "Private Clinics"),
                              Divider(),
                              getCat(context, "18", "Specialist"),
                              Divider(),
                              getCat(context, "20", "Dental Surgeons"),
                              Divider(),
                              getCat(context, "21", "Dentist"),
                              Divider(),
                              getCat(context, "22", "Dermatologists"),
                              Divider(),
                              getCat(context, "23", "Dieticians"),
                              Divider(),
                              getCat(context, "24", "District Surgeons"),
                              Divider(),
                              getCat(
                                  context, "25", "Ear Nose & Throat Surgeons"),
                              Divider(),
                              getCat(context, "26", "Emergency Medicines"),
                              Divider(),
                              getCat(context, "27", "Emergency Services"),
                              Divider(),
                              getCat(context, "28", "Endocrinologists "),
                              Divider(),
                              getCat(context, "29", "Gastroenterologists"),
                              Divider(),
                              getCat(context, "30", "General Practitioner"),
                              Divider(),
                              getCat(context, "32", "Gynaecologist"),
                              Divider(),
                              getCat(context, "33", "Health & Beauty"),
                              Divider(),
                              getCat(context, "34", "Health Insurance"),
                              Divider(),
                              getCat(context, "35", "Healthcare Suppliers"),
                              Divider(),
                              getCat(context, "36", "Hearing Aids"),
                              Divider(),
                              getCat(context, "37", "Hematologists"),
                              Divider(),
                              getCat(context, "38", "HIV/AIDS"),
                              Divider(),
                              getCat(context, "39", "Homeopaths"),
                              Divider(),
                              getCat(context, "40", "Hospital & Clinic Groups"),
                              Divider(),
                              getCat(context, "41",
                                  "Hospitals - Government - Private"),
                              Divider(),
                              getCat(context, "42", "Hospital Specialist"),
                              Divider(),
                              getCat(context, "43",
                                  "Infectious Disease Specialists"),
                              Divider(),
                              getCat(context, "44", "Managed Health Care"),
                              Divider(),
                              getCat(context, "45", "Massage Therapists"),
                              Divider(),
                              getCat(context, "46",
                                  "Medical Aid Schemes and Administrators"),
                              Divider(),
                              getCat(context, "48", "Medical Practitioners"),
                              Divider(),
                              getCat(context, "49", "Medical Publishers"),
                              Divider(),
                              getCat(context, "50", "Medical Scientists"),
                              Divider(),
                              getCat(context, "51", "Medical Suppliers"),
                              Divider(),
                              getCat(context, "52", "Medical Technicians"),
                              Divider(),
                              getCat(context, "54", "Microbiology"),
                              Divider(),
                              getCat(context, "55", "Naturopaths"),
                              Divider(),
                              getCat(context, "56", "Neonatologists"),
                              Divider(),
                              getCat(context, "57", "Nephrologists"),
                              Divider(),
                              getCat(context, "58", "Neurologist"),
                              Divider(),
                              getCat(context, "59", "Neurosurgeons"),
                              Divider(),
                              getCat(context, "61", "Nuclear Medicine"),
                              Divider(),
                              getCat(context, "62",
                                  "Nurses : Professional,Registered"),
                              Divider(),
                              getCat(context, "63", "Nutritional Therapists"),
                              Divider(),
                              getCat(context, "64", "Occupational Health"),
                              Divider(),
                              getCat(context, "65", "Occupational Medicine"),
                              Divider(),
                              getCat(context, "66", "Occupational Therapists"),
                              Divider(),
                              getCat(context, "67", "Oncology"),
                              Divider(),
                              getCat(context, "68", "Ophthalmology"),
                              Divider(),
                              getCat(context, "69", "Optometrists"),
                              Divider(),
                              getCat(context, "70", "Oral Hygiene"),
                              Divider(),
                              getCat(context, "71", "Orthodontics"),
                              Divider(),
                              getCat(context, "72", "Orthopedic"),
                              Divider(),
                              getCat(context, "73", "Orthotics & Prosthetics"),
                              Divider(),
                              getCat(context, "74", "Osteopaths"),
                              Divider(),
                              getCat(context, "75", "Pathologists"),
                              Divider(),
                              getCat(context, "76", "Pediatricians"),
                              Divider(),
                              getCat(context, "77", "Pediatrics"),
                              Divider(),
                              getCat(context, "79", "Personal Trainers"),
                              Divider(),
                              getCat(context, "80",
                                  "Pharmaceutical Manufacturers"),
                              Divider(),
                              getCat(context, "81", "Pharmaceutical Suppliers"),
                              Divider(),
                              getCat(context, "82", "Pharmacies - Retails"),
                              Divider(),
                              getCat(context, "83", "Pharmacies - Wholesale"),
                              Divider(),
                              getCat(context, "84", "Pharmacologists"),
                              Divider(),
                              getCat(context, "85", "Pharmacotherapy"),
                              Divider(),
                              getCat(context, "86", "Pharmacy Clinics"),
                              Divider(),
                              getCat(context, "87", "Pharmacy Groups"),
                              Divider(),
                              getCat(context, "89", "Physicians"),
                              Divider(),
                              getCat(context, "90", "Physiotherapy"),
                              Divider(),
                              getCat(context, "91", "Plastic Surgeons"),
                              Divider(),
                              getCat(context, "92", "Podiatrists"),
                              Divider(),
                              getCat(context, "93", "Prosthodontics"),
                              Divider(),
                              getCat(context, "94", "Psychiatry"),
                              Divider(),
                              getCat(context, "95", "Psychology"),
                              Divider(),
                              getCat(context, "96", "Psychometrics"),
                              Divider(),
                              getCat(
                                  context, "97", "Public Health Specialists"),
                              Divider(),
                              getCat(context, "98", "Pulmonologists"),
                              Divider(),
                              getCat(context, "99", "Radiographers"),
                              Divider(),
                              getCat(context, "100", "Radiologists"),
                              Divider(),
                              getCat(context, "101", "Radiotherapists"),
                              Divider(),
                              getCat(context, "102", "Recruitment"),
                              Divider(),
                              getCat(context, "103", "Reflexology"),
                              Divider(),
                              getCat(context, "104", "Reproductive Medicine"),
                              Divider(),
                              getCat(context, "105", "Rheumatologists"),
                              Divider(),
                              getCat(context, "106", "Sexologists"),
                              Divider(),
                              getCat(context, "107", "Sexuality"),
                              Divider(),
                              getCat(context, "108",
                                  "Social Services : Associations, Info, Support etc"),
                              Divider(),
                              getCat(context, "109", "Speech"),
                              Divider(),
                              getCat(context, "110", "Sports Medicine"),
                              Divider(),
                              getCat(context, "111", "Surgeons"),
                              Divider(),
                              getCat(context, "112", "Training Institutions"),
                              Divider(),
                              getCat(context, "113", "Urologists"),
                              Divider(),
                              getCat(context, "114", "Vascular Surgeons"),
                              Divider(),
                              getCat(context, "115", "Veterinary Clinics"),
                              Divider(),
                              getCat(context, "116", "Veterinary surgeons"),
                              Divider(),
                              getCat(context, "117", "Other"),
                              Divider(),
                              getCat(context, "118", "Medical Finance"),
                              Divider(),
                              getCat(context, "119",
                                  "Renewable Energy & Back Up Power"),
                              Divider(),
                              getCat(context, "120", "Auxiliary Services"),
                              Divider(),
                              getCat(context, "121", "Air Purifiers"),
                              Divider(),
                              getCat(
                                  context, "122", "Medical Waste Management"),
                              Divider(),
                              getCat(context, "123", "Pest Control"),
                              Divider(),
                              getCat(context, "125",
                                  "Medical Device Manufacturers"),
                              Divider(),
                              getCat(context, "113", "Allergies"),
                              Divider(),
                              Text("")
                            ]);
                          },
                        )),
                  ],
                ),
              ),
            ])),
        bottomNavigationBar: footer(context)
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

Widget getCat(context, id_, cat_) {
  return GestureDetector(
      onTap: () => {
            Navigator.pushNamed(context, '/bycat_',
                arguments: {'catid': '$id_', 'catname': '$cat_'})
          },
      child: Row(children: [
        Icon(
          Icons.more_vert,
          size: 17,
          color: Color.fromARGB(255, 5, 82, 119),
        ),
        Text(
          " $cat_",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color.fromARGB(255, 5, 82, 119)),
        ),
      ]));
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

Widget button(context) {
  return Container(
      width: 36, // Set the width of the container
      height: 25, // Set the height of the container
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white, // Set the background color
        borderRadius: BorderRadius.circular(
            0.0), // Set the border radius to make corners rounded
      ),
      child: Icon(Icons.search));
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
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Image.network(
                  'https://cdn.adslive.com/uploads/logos/placeholder/logo.png');
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
              fontWeight: FontWeight.bold, fontSize: 10, color: Colors.grey),
        ),
        Text(
          " $address_".substring(0, 20),
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
          " $article".substring(0, 30),
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
