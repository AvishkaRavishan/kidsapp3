import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/teacherchat.dart';
import 'package:mobile_application_kids/classroomview.dart';
import 'package:mobile_application_kids/addclassroom.dart';
import 'package:mobile_application_kids/teacherhome.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChatScreen.dart';
import 'TeacherProfile.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
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
    "Present": 0,
    "Absent": 0,
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
              'Attendance  ',
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
                //   ' ',
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
                    padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
                    child: Container(
                      width: 358,
                      height: 76,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Today’s Present Count',
                            style: TextStyle(
                              color: Color(0xFF21205B),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0.06,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 40,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 21, vertical: 12),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 1,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Male',
                                        style: TextStyle(
                                          color: Color(0xFF21205B),
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0.07,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      SizedBox(
                                          width: 30,
                                          child: FutureBuilder<String>(
                                              future: getMaleStudentCount(
                                                  'Male', 0),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  // Future is still loading, show a loading indicator
                                                  return CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  // Error occurred while fetching data
                                                  return Text('0');
                                                } else {
                                                  return Text(' ' +
                                                      snapshot.data.toString());
                                                }
                                              })),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 1,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Female',
                                        style: TextStyle(
                                          color: Color(0xFF21205B),
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0.07,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      SizedBox(
                                        width: 30,
                                        child: FutureBuilder<String>(
                                            future: getMaleStudentCount(
                                                'Female', 0),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                // Future is still loading, show a loading indicator
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                // Error occurred while fetching data
                                                return Text('0');
                                              } else {
                                                return Text(' ' +
                                                    snapshot.data.toString());
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF48B62C),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 53,
                                        child: Text(
                                          'All',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0.07,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      FutureBuilder<String>(
                                        future: getAllStudentCount(0),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // Future is still loading, show a loading indicator
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            // Error occurred while fetching data

                                            return Text('0');
                                          } else {
                                            return Text(
                                              snapshot.data.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                height: 0.06,
                                              ),
                                            );
                                          }
                                        },
                                      )
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
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Container(
                      width: 358,
                      height: 76,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Today’s Absent Count',
                            style: TextStyle(
                              color: Color(0xFF21205B),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0.06,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 40,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 21, vertical: 12),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 1,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Male',
                                        style: TextStyle(
                                          color: Color(0xFF21205B),
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0.07,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      SizedBox(
                                          width: 30,
                                          child: FutureBuilder<String>(
                                              future: getMaleStudentCount(
                                                  'Male', 1),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  // Future is still loading, show a loading indicator
                                                  return CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  // Error occurred while fetching data
                                                  return Text('0');
                                                } else {
                                                  return Text(' ' +
                                                      snapshot.data.toString());
                                                }
                                              })),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 1,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Female',
                                        style: TextStyle(
                                          color: Color(0xFF21205B),
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0.07,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      SizedBox(
                                          width: 30,
                                          child: FutureBuilder<String>(
                                              future: getMaleStudentCount(
                                                  'Female', 1),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  // Future is still loading, show a loading indicator
                                                  return CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  // Error occurred while fetching data
                                                  return Text('0');
                                                } else {
                                                  return Text(' ' +
                                                      snapshot.data.toString());
                                                }
                                              })),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFEF4B4B),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 53,
                                        child: Text(
                                          'All',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0.07,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      FutureBuilder<String>(
                                        future: getAllStudentCount(1),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // Future is still loading, show a loading indicator
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            // Error occurred while fetching data

                                            return Text('0');
                                          } else {
                                            // Data loaded successfully, display it

                                            return Text(
                                              snapshot.data.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                height: 0.06,
                                              ),
                                            );
                                          }
                                        },
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
                                  'Attendance Summary ',
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
                                                'Attendance  ',
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
                                                  Color.fromARGB(
                                                      255, 83, 172, 255),
                                                  Color.fromARGB(
                                                      255, 106, 210, 255),
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
          selectedItemColor: Color.fromARGB(255, 103, 103, 103),
          onTap: (index) {
            // Handle bottom navigation item tap
            switch (index) {
              case 0:
                // Navigate to Home
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeacherHomePage()),
                );
                break;
              case 1:
                // Navigate to Chat
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
                break;
              case 2:
                // Navigate to Profile
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TeacherProfilePage(uid: user?.uid)),
                );
                break;
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
        dataMap["Present"] = pre.round().toDouble();
        dataMap["Absent"] = abs.round().toDouble();
      });
      print("ss" + preCount.round().toString());
    } catch (e) {
      print('Error getting male student count: $e');
    }
  }
}
