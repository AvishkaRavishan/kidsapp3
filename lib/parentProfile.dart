import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/ChatScreen.dart';
import 'package:mobile_application_kids/p_or_t.dart';
import 'package:mobile_application_kids/parenthome.dart';

class ParentProfilePage extends StatefulWidget {
  final String? uid;
  final String phoneNo;
  final String role;

  ParentProfilePage({required this.uid, required this.phoneNo, required this.role, Key? key});

  @override
  _ParentProfilePageState createState() => _ParentProfilePageState(uid!, phoneNo, role);
}

class _ParentProfilePageState extends State<ParentProfilePage> {
  late User? user;
  late String fullName = "";
  late String email = "";
  late String phoneNo = ""; 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late String role;

  _ParentProfilePageState(this.uid, this.phoneNo, this.role);

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      
      if (documentSnapshot.exists) {
        Map<String, dynamic> targetDoc = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          fullName = targetDoc['fullName'];
          email = targetDoc['email'];
          phoneNo = targetDoc['phoneNo']; 
        });
        print("Full Name: $fullName, Email: $email, Phone Number: $phoneNo"); 
      } else {
        print("Document does not exist");
      }
    } catch (error) {
      print("Error getting document: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16),
            child: Text('Parent Profile',
            style: TextStyle(
                color: Color(0xFF554994),
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 0.04,
                letterSpacing: -0.96,
              ),
            ), 
          ), 
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/parentprof.PNG'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              height: 300, // Adjust height as needed
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      'Full Name: $fullName',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      'Email: $email',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      'Phone Number: $phoneNo',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _signOut(context),
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
              MaterialPageRoute(builder: (context) => ParentHomePage(phoneNo, role)),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          }
        },
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => ParentTeacherPage(backgroundColor: Color.fromARGB(255, 255, 255, 255))),
        (route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
