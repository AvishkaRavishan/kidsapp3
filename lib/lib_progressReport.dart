import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/teacherchat.dart';
import 'package:mobile_application_kids/classroomview.dart';
import 'package:mobile_application_kids/addclassroom.dart';
import 'package:mobile_application_kids/teacherhome.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'ChatScreen.dart';
import 'TeacherProfile.dart';

class progressReport extends StatefulWidget {
  @override
  _progressReportState createState() => _progressReportState();
}

class _progressReportState extends State<progressReport> {
  late User? user;
  late final Stream<QuerySnapshot> _usersStream;
  int absCount = 0;
  int preCount = 0;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    initializeStreams();
    getAllStudentCountPresentAbs();
  }

  Map<String, double> dataMap = {
    "Good": 0,
    "Netural": 0,
    "Week": 0,
  };

  void initializeStreams() {
    _usersStream = FirebaseFirestore.instance
        .collection('students')
        .where('user', isEqualTo: user?.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button press
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Text(
              'Progress Report  ',
              style: TextStyle(
                color: Color(0xFF554994),
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 0.04,
                letterSpacing: -0.96,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Activity Scale ',
                //   style: TextStyle(
                //     color: Color(0xFF11324D),
                //     fontSize: 24,
                //     fontFamily: 'Poppins',
                //     fontWeight: FontWeight.w500,
                //     height: 0.04,
                //     letterSpacing: -0.96,
                //   ),
                // ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    child: Container(
                      width: 358,
                      height: 362,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Activity Scale ',
                                  style: TextStyle(
                                    color: Color(0xFF21205B),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            height: 316,
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 18,
                              right: 17,
                              bottom: 18,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300,
                                  height: 282,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 157,
                                              height: 13,
                                              child: Text(
                                                '  ',
                                                style: TextStyle(
                                                  color: Color(0xFF2B3674),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.07,
                                                  letterSpacing: -0.28,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 300,
                                          height: 250,
                                          child: Stack(
                                            children: [
                                              PieChart(
                                                dataMap: dataMap,
                                                chartType: ChartType.disc,
                                                chartRadius:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2.2,
                                                colorList: [
                                                  Color(0xFFFFD452),
                                                  Color(0xFFCE7BB0),
                                                  Color(0xFFFF8080)
                                                ],
                                                legendOptions: LegendOptions(
                                                  showLegendsInRow: true,
                                                  legendPosition:
                                                      LegendPosition.bottom,
                                                  showLegends: true,
                                                  legendTextStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                chartValuesOptions:
                                                    ChartValuesOptions(
                                                  showChartValueBackground:
                                                      true,
                                                  showChartValues: true,
                                                  showChartValuesInPercentage:
                                                      true,
                                                  showChartValuesOutside: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    child: Container(
                      width: 358,
                      height: 362,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LD Director ',
                                  style: TextStyle(
                                    color: Color(0xFF21205B),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            height: 316,
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 18,
                              right: 17,
                              bottom: 18,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300,
                                  height: 282,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 157,
                                              height: 13,
                                              child: Text(
                                                '  ',
                                                style: TextStyle(
                                                  color: Color(0xFF2B3674),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.07,
                                                  letterSpacing: -0.28,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 300,
                                          height: 250,
                                          child: Stack(
                                            children: [
                                              charts.BarChart(
                                                _createSampleData(),
                                                animate: true,
                                                vertical:
                                                    true, // To display horizontal bar chart
                                                barRendererDecorator:
                                                    charts.BarLabelDecorator<
                                                        String>(),
                                                domainAxis:
                                                    charts.OrdinalAxisSpec(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),

                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    child: Container(
                      width: 358,
                      height: 362,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Assement Progress ',
                                  style: TextStyle(
                                    color: Color(0xFF21205B),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            height: 316,
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 18,
                              right: 17,
                              bottom: 18,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300,
                                  height: 282,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 157,
                                              height: 13,
                                              child: Text(
                                                '  ',
                                                style: TextStyle(
                                                  color: Color(0xFF2B3674),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.07,
                                                  letterSpacing: -0.28,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 300,
                                          height: 250,
                                          child: Stack(
                                            children: [
                                              charts.BarChart(
                                                _createSampleData(),
                                                animate: true,
                                                vertical:
                                                    true, // To display horizontal bar chart
                                                barRendererDecorator:
                                                    charts.BarLabelDecorator<
                                                        String>(),
                                                domainAxis:
                                                    charts.OrdinalAxisSpec(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue,
          onTap: (index) async {
            final prefs = await SharedPreferences.getInstance();
            String rool = prefs.get('rool').toString();
            // Handle bottom navigation item tap

            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TeacherHomePage()),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TeacherProfilePage(uid: user?.uid)),
              );
            }
          },
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getStudentsStream(String genderFilter, int isCheck) {
    return FirebaseFirestore.instance
        .collection('students')
        .where('user', isEqualTo: user?.uid)
        .where('Sex', isEqualTo: genderFilter)
        .where('isCheck', isEqualTo: isCheck)
        .snapshots();
  }

  Future<String> getMaleStudentCount(String sex, int isCheck) async {
    try {
      QuerySnapshot snapshot = await getStudentsStream(sex, isCheck).first;
      return snapshot.size.toString();
    } catch (e) {
      print('Error getting male student count: $e');
      return '0';
    }
  }

  Stream<QuerySnapshot> getAllStudentsStream(int isCheck) {
    return FirebaseFirestore.instance
        .collection('students')
        .where('user', isEqualTo: user?.uid)
        .where('isCheck', isEqualTo: isCheck)
        .snapshots();
  }

  Future<String> getAllStudentCount(int isCheck) async {
    try {
      QuerySnapshot snapshot = await getAllStudentsStream(isCheck).first;

      print('size' + snapshot.size.toString());
      return snapshot.size.toString();
    } catch (e) {
      print('Error getting male student count: $e');
      return '0';
    }
  }

  Stream<QuerySnapshot> getAllStudentsStreams() {
    return FirebaseFirestore.instance
        .collection('students')
        .where('user', isEqualTo: user?.uid)
        .snapshots();
  }

  Future<void> getAllStudentCountPresentAbs() async {
    try {
      QuerySnapshot snapshot2 = await getAllStudentsStreams().first;
      QuerySnapshot snapshot = await getAllStudentsStream(0).first;
      QuerySnapshot snapshotAbs = await getAllStudentsStream(1).first;
      preCount = snapshot.size;
      absCount = snapshotAbs.size;
      var pre = (snapshot.size / snapshot2.size) * 100;
      var abs = (snapshotAbs.size / snapshot2.size) * 100;

      setState(() {
        dataMap["Good"] = 25.0;
        dataMap["Netural"] = 35.0;
        dataMap["Week"] = 40.0;
      });
      print("ss" + preCount.round().toString());
    } catch (e) {
      print('Error getting male student count: $e');
    }
  }

  List<charts.Series<SymptomData, String>> _createSampleData() {
    final data = [
      SymptomData('Dyslexia', 90, Colors.pink),
      SymptomData('DCD', 3, Colors.purple),
      SymptomData('ADHD', 5, Colors.green),
      SymptomData('ASD', 2, Colors.blue),
    ];

    return [
      charts.Series<SymptomData, String>(
        id: 'Symptoms',
        domainFn: (SymptomData symptoms, _) => symptoms.symptom,
        measureFn: (SymptomData symptoms, _) => symptoms.percentage,
        colorFn: (SymptomData symptoms, _) => symptoms.color,
        data: data,
        labelAccessorFn: (SymptomData row, _) => '${row.percentage}%',
      )
    ];
  }
}

class SymptomData {
  final String symptom;
  final int percentage;
  final charts.Color color;

  SymptomData(this.symptom, this.percentage, Color color)
      : this.color = charts.Color(
          r: color.red,
          g: color.green,
          b: color.blue,
          a: color.alpha,
        );
}
