import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/classroomview.dart';
import 'package:mobile_application_kids/addclassroom.dart';
import 'package:mobile_application_kids/teacherchat.dart';

import 'ChatScreen.dart';
import 'TeacherProfile.dart';

class TeacherHomePage extends StatelessWidget {
  late User? user;
  late final Stream<QuerySnapshot> _usersStream;
  TeacherHomePage() {
    user = FirebaseAuth.instance.currentUser;
    initializeStreams();
  }

  void initializeStreams() {
    _usersStream = FirebaseFirestore.instance
        .collection('classroom')
        .where('userId', isEqualTo: user?.uid)
        .snapshots();
  }

  // Define a TextStyle with the Poppins font
  final TextStyle poppinsTextStyle = TextStyle(
    fontFamily: 'Poppins',
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button press
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Container(
            width: 230, 
            child: Image.asset(
              'lib/assets/i2.png',
              fit: BoxFit.fitHeight,
              alignment: Alignment.topLeft, 
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle notification icon press
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Explore, learn, and play in our magical world of wonder!',
                style: poppinsTextStyle.copyWith(
                  // fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'lib/assets/teacherhome.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to the AddClassroomPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddClassroomPage()),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(height: 12),
                        Text(
                          'Create New Class Room Here',
                          style: poppinsTextStyle.copyWith(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.only(left: 23.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white, // Set the icon color to white
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 8),
              Text(
                'Class Rooms',
                style: poppinsTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (context, snapshot) {
                    print("--------------------------------------");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    var itemcount = snapshot.data!.docs.length;

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var document = snapshot.data!.docs[index];
                        var className = document['className'];
                        print(document);
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0), // Adjust the spacing as needed
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 27.0,
                              backgroundImage:
                                  AssetImage('lib/assets/classlogo.png'),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '$className',
                                      style: poppinsTextStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Class $index',
                                      style: poppinsTextStyle.copyWith(
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Container(
                              height: 40.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  print(document);
                                  // Handle view class button press
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClassroomViewPage(
                                        documents: className,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'View',
                                  style: poppinsTextStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
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
          selectedItemColor: Colors.blue,
          onTap: (index) {
            // Handle bottom navigation item tap
            switch (index) {
              case 0:
                // Navigate to Home
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
