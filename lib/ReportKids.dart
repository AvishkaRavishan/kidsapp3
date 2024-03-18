import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/teacherchat.dart';
import 'package:mobile_application_kids/classroomview.dart';
import 'package:mobile_application_kids/addclassroom.dart';
import 'package:mobile_application_kids/teacherhome.dart';

import 'ChatScreen.dart';
import 'TeacherProfile.dart';
import 'kidsReport.dart'; // Import the AddClassroomPage file

class ReportKidsPage extends StatelessWidget {
  late User? user;
  late final Stream<QuerySnapshot> _usersStream;
  String classroom;
  ReportKidsPage({required this.classroom}) {
    user = FirebaseAuth.instance.currentUser;
    initializeStreams();
  }

  void initializeStreams() {
    _usersStream = FirebaseFirestore.instance
        .collection('students')
        .where('user', isEqualTo: user?.uid)
        .where('className', isEqualTo: classroom)
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
              'Report  ',
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Bright Sparkle ',
              //   style: TextStyle(
              //     color: Color(0xFF11324D),
              //     fontSize: 24,
              //     fontFamily: 'Poppins',
              //     fontWeight: FontWeight.w500,
              //     height: 0.04,
              //     letterSpacing: -0.96,
              //   ),
              // ),
              SizedBox(height: 20), // sspace here between texts
              Text(
                'Select Kids ',
                style: TextStyle(
                  color: Color(0xFF21205B),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.06,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (context, snapshot) {
                    print("--------------------------------------");
                    // print(snapshot.data!.docs.length);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    var itemCount = snapshot.data!.docs.length;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            4, // Adjust this value to control the number of items per row
                        crossAxisSpacing:
                            8.0, // Adjust spacing between items horizontally
                        mainAxisSpacing:
                            8.0, // Adjust spacing between items vertically
                      ),
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        var document = snapshot.data!.docs[index];
                        var className = document['Firstname'];

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: InkWell(
                            onTap: () {
                              print(document);
                              // Handle view class button press
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      KidsReportPage(id: document.id),
                                ),
                              );
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 74.24,
                                    height: 74.24,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 74.24,
                                            height: 74.24,
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
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 74.24,
                                            height: 74.24,
                                            decoration: ShapeDecoration(
                                              color: Color(0x4CB8B4B4),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 7.42,
                                          top: 51.97,
                                          child: Container(
                                            width: 59.40,
                                            padding: const EdgeInsets.all(4.95),
                                            decoration: ShapeDecoration(
                                              color: Color(0xDD7D8088),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.95),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  className,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.37,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0.08,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
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
}
