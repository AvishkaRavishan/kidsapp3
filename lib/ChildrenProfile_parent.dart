import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/progressReport.dart';
import 'package:mobile_application_kids/teacherchat.dart';
import 'package:mobile_application_kids/classroomview.dart';
import 'package:mobile_application_kids/addclassroom.dart';
import 'package:mobile_application_kids/teacherhome.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ActivitiesView.dart';
import 'ChatScreen.dart';
import 'TeacherProfile.dart';
import 'kidsReportView.dart';

class pChildrenProfilePage extends StatelessWidget {
  late User? user;
  late final Stream<QuerySnapshot> _usersStream, _usersStream2;
  int _age = 10;
  String role = '';
  late final userDetails;
  pChildrenProfilePage(document, role) {
    print(role);
    this.role = role;
    this.userDetails = document;
    user = FirebaseAuth.instance.currentUser;
    initializeStreams();
    calculateAge(userDetails['Birthday']);
  }

  void initializeStreams() {
    _usersStream = FirebaseFirestore.instance
        .collection('classroom')
        .where('userId', isEqualTo: user?.uid)
        .snapshots();

    _usersStream2 = FirebaseFirestore.instance
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
              'Children     ',
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userDetails['className'],
                // 'Bright Sparkle ',
                style: TextStyle(
                  color: Color(0xFF11324D),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.04,
                  letterSpacing: -0.96,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(5, 40, 5, 5),
                  child: Container(
                      width: 358,
                      height: 255,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.64),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x0C000000),
                            blurRadius: 181.84,
                            offset: Offset(0, 4.55),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Container(
                                      width: 84,
                                      height: 84,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "lib/assets/Ellipse 8.png"),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 11),
                                  Container(
                                    width: double.infinity,
                                    height: 20,
                                    padding: const EdgeInsets.only(
                                        left: 45, right: 43),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 124,
                                          height: double.infinity,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userDetails['Firstname'],
                                                style: TextStyle(
                                                  color: Color(0xFF11324D),
                                                  fontSize: 20,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0.06,
                                                  letterSpacing: -0.80,
                                                ),
                                              ),
                                              const SizedBox(width: 3),
                                              Container(
                                                width: 7,
                                                height: 7,
                                                decoration: ShapeDecoration(
                                                  color: Color(0xFF00E332),
                                                  shape: OvalBorder(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 11),
                                  Text(
                                    userDetails['role'],
                                    style: TextStyle(
                                      color: Color(0xFF21205B),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0.07,
                                    ),
                                  ),
                                  const SizedBox(height: 11),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Age',
                                                  style: TextStyle(
                                                    color: Color(0xFF21205B),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' : ',
                                                  style: TextStyle(
                                                    color: Color(0xFF21205B),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: _age.toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFF21205B),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 17),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Birthday',
                                                  style: TextStyle(
                                                    color: Color(0xFF21205B),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' :  ',
                                                  style: TextStyle(
                                                    color: Color(0xFF21205B),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: userDetails['Birthday'],
                                                  style: TextStyle(
                                                    color: Color(0xFF21205B),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 17),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Sex',
                                                  style: TextStyle(
                                                    color: Color(0xFF21205B),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' : ',
                                                  style: TextStyle(
                                                    color: Color(0xFF21205B),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: userDetails['Sex'],
                                                  style: TextStyle(
                                                    color: Color(0xFF21205B),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        50, 20, 40, 0),
                                    child: Container(
                                      width: 302,
                                      height: 37,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              top: 12,
                                              left: 10,
                                              bottom: 11.63,
                                            ),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              shadows: [
                                                BoxShadow(
                                                  color: Color(0x3F000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 1),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChatScreen()),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: double.infinity,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.chat,
                                                            color:
                                                                Colors.black26,
                                                          ),
                                                          Text(
                                                            'Chat',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0.08,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Container(
                                            padding: const EdgeInsets.only(
                                              top: 12,
                                              left: 10,
                                              bottom: 11.63,
                                            ),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              shadows: [
                                                BoxShadow(
                                                  color: Color(0x3F000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 1),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _getPhoneNumber(user?.uid);
                                                  },
                                                  child: Container(
                                                    height: double.infinity,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.call,
                                                          color: Colors.black26,
                                                        ),
                                                        Text(
                                                          'Call',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0.08,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserActivitiesScreen(
                                                            userId: user!.uid)),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                top: 11,
                                                bottom: 12,
                                              ),
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 1),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: double.infinity,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.book,
                                                          color: Colors.black26,
                                                        ),
                                                        Text(
                                                          'Activites',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 30, 0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      role == "P"
                          ? Container(
                              width: 359,
                              height: 178,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 359,
                                    height: 128,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage("lib/assets/banner.png"),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 20,
                                          offset: Offset(0, 2),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 18), //play game button
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF48B62C),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Play Here ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.06,
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
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Report',
                        style: TextStyle(
                          color: Color(0xFF21205B),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0.06,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04),
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ReportKidsViewPage(
                                                sid: userDetails.id)),
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 135,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 135,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFF1EFFF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.44),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 16,
                                        top: 17,
                                        child: Container(
                                          width: 119.18,
                                          height: 100.88,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                child: Container(
                                                  width: 16.88,
                                                  height: 16.88,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(),
                                                  child: Stack(children: [
                                                    Icon(
                                                      Icons.person_3,
                                                      color: Colors.black26,
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              const SizedBox(height: 0),
                                              SizedBox(
                                                width: 119.18,
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Monthly \npsycholo. report \n  ',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF403572),
                                                          fontSize: 14,
                                                          fontFamily: 'poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                              // letterSpacing: 0.08,
                                                          height: 0.9,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 1),
                                              SizedBox(
                                                width: 119.18,
                                                child: Opacity(
                                                  opacity: 0.70,
                                                  child: Text(
                                                    'Some short description of this type of report.',
                                                    style: TextStyle(
                                                      color: Color(0xFF8DAEAE),
                                                      fontSize: 9.55,
                                                      fontFamily: 'poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              progressReport()));
                                },
                                child: Container(
                                  width: 150,
                                  height: 135,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 170,
                                          height: 135,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFC4F3F3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.44),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 16,
                                        top: 17,
                                        child: Container(
                                          width: 119.18,
                                          height: 100.88,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                child: Container(
                                                  width: 16.88,
                                                  height: 16.88,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(),
                                                  child: Stack(children: [
                                                    Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.black26,
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              const SizedBox(height: 1),
                                              SizedBox(
                                                width: 119.18,
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Monthly prediction report \n',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF479696),
                                                          fontSize: 14,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0.9,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 1),
                                              SizedBox(
                                                width: 119.18,
                                                child: Opacity(
                                                  opacity: 0.70,
                                                  child: Text(
                                                    'Some short description of this type of report.',
                                                    style: TextStyle(
                                                      color: Color(0xFF8DAEAE),
                                                      fontSize: 9.55,
                                                      fontFamily: 'poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
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
          onTap: (index) {
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

  _launchPhone(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String?> _getPhoneNumber(userUID) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('user', isEqualTo: userUID)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Assuming 'phone' is the field containing the phone number
        String mobile = snapshot.docs.first['Parentphone'];
        final url = 'tel:$mobile';
        _launchPhone(url);
      } else {
        return null; // Document not found
      }
    } catch (e) {
      print("Error getting phone number: $e");
      return null;
    }
  }

  void calculateAge(birthday) {
    String birthdayText = birthday.trim();
    if (birthdayText.isNotEmpty) {
      try {
        DateTime birthday = DateTime.parse(birthdayText);
        DateTime now = DateTime.now();
        Duration difference = now.difference(birthday);

        _age = (difference.inDays / 365).floor();
      } catch (e) {
        print('Invalid date format: $e');
        // Handle invalid date format
      }
    } else {
      // Handle empty input
    }
  }
}
