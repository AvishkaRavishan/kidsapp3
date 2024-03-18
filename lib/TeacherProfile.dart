import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/login.dart';
import 'package:mobile_application_kids/p_or_t.dart';
import 'package:mobile_application_kids/teacherchat.dart';
import 'package:mobile_application_kids/teacherhome.dart';

import 'ChatScreen.dart';

class TeacherProfilePage extends StatefulWidget {
  final String? uid;

  TeacherProfilePage({required this.uid, Key? key});

  @override
  _TeacherProfilePageState createState() => _TeacherProfilePageState(uid);
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  late User? user;
  late String fullName = "";
  late String email = "";
  late String state = "";
  late String capacity = "";
  late String school = "";
  late Map<String, dynamic> targetDoc;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;

  _TeacherProfilePageState(uid) {
    this.uid = uid;
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    getUserData();
  }

  Future<void> getUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        targetDoc = documentSnapshot.data() as Map<String, dynamic>? ?? {};
        setState(() {
          fullName = targetDoc['fullName'];
          email = targetDoc['email'];
          state = targetDoc['state'];
          capacity = targetDoc['enrolmentCapacity'];
          school = targetDoc['school'];
        });
      } else {
        print("Document does not exist");
      }
    }).catchError((error) {
      print("Error getting document: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Teacher Profile',
                style: TextStyle(
                  color: Color(0xFF554994),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "lib/assets/teacherprof.png",
                    fit: BoxFit.fitHeight,
                    height: 300,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Name: $fullName',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10), 
                Text(
                  'Email: $email',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10), 
                Text(
                  'Address: $state',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10), 
                Text(
                  'Capacity: $capacity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10), 
                Text(
                  'School: $school',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _signOut,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Sign Out',
                        style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ),
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
          currentIndex: 2,
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TeacherHomePage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeacherProfilePage(uid: user?.uid),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParentTeacherPage(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
