import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_application_kids/Attendance.dart';
import 'package:mobile_application_kids/ChatScreen.dart';
import 'package:mobile_application_kids/ChildrenVideo.dart';
import 'package:mobile_application_kids/ReportKids.dart';
import 'package:mobile_application_kids/TeacherProfile.dart';
import 'package:mobile_application_kids/teacherhome.dart';
import 'CheckKids.dart';
import 'ChildrenActiPhone.dart';
import 'ChildrenHomePage.dart';
import 'addstudent.dart';

class ChildrenActivity extends StatelessWidget {
  late Future<List<DocumentSnapshot>> students = getStudentData();
  final TextEditingController _searchController = TextEditingController();
  late StreamController<String> _searchTermController;

  late User? user;

  ChildrenActivity({super.key}) {
    user = FirebaseAuth.instance.currentUser;
  }

  Future<List<DocumentSnapshot>> getStudentData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('students').get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Text(
            'Activities  ',
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
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.1, 20, width * 0.1, 20),
                child: Container(
                  width: 293,
                  height: 44,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      _searchTermController.add(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                      suffixIcon: Icon(Icons.mic),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 0.6),
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      onTap: () {
                        openCamera(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 170,
                          height: 85,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'lib/assets/ac1.png'), 
                            fit: BoxFit
                                .cover, 
                          )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        openVideoRecorder(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 170,
                          height: 85,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'lib/assets/ac2.png'), 
                            fit: BoxFit
                                .cover, 
                          )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ChildrenActivity(),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 170,
                          height: 85,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'lib/assets/ac7.png'), 
                            fit: BoxFit
                                .cover, 
                          )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CheckKidsPage(),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 170,
                          height: 85,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'lib/assets/ac4.png'), 
                            fit: BoxFit
                                .cover, 
                          )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (_) => ReportKidsPage( classroom: ),
                        // ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 170,
                          height: 85,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'lib/assets/ac6.png'), 
                            fit: BoxFit
                                .cover, 
                          )),
                        ),
                      ),
                    ),
                  ]),
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
    );
  }

  void openCamera(context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChildrenActiPhone(image: imagePath)),
      );

      // Use the picked file, for example, display it in an Image widget
      // Image.file(File(pickedFile.path))
      print('Image selected: ${pickedFile.path}');
    } else {
      print('No image selected');
    }
  }

  void openVideoRecorder(context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChildrenVideo(video: imagePath)),
      );

      // Use the picked file, for example, display it in a Video widget
      // Video.file(File(pickedFile.path))
      print('Video selected: ${pickedFile.path}');
    } else {
      print('No video selected');
    }
  }
}
