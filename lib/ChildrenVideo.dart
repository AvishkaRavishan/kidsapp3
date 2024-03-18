import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/teacherchat.dart';
import 'package:mobile_application_kids/classroomview.dart';
import 'package:mobile_application_kids/addclassroom.dart';
import 'package:video_player/video_player.dart';

import 'TeacherProfile.dart';

class ChildrenVideo extends StatelessWidget {
  late User? user;
  late String video;
  late VideoPlayerController videoPlayerController;

  late final Stream<QuerySnapshot> _usersStream;
  ChildrenVideo({required this.video}) {
    user = FirebaseAuth.instance.currentUser;
    initializeStreams();
  }

  Future<void> initializeStreams() async {
    _usersStream = FirebaseFirestore.instance
        .collection('students')
        .where('user', isEqualTo: user?.uid)
        .snapshots();

    videoPlayerController = VideoPlayerController.file(File(video));
    await videoPlayerController.initialize();
    await videoPlayerController
        .setLooping(true); // Optional: Set looping to true
    await videoPlayerController.play();
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
              'Video  ',
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
              Center(
                child: Container(
                  height: 400,
                  child: AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController),
                  ),
                ),
              ), //)
              SizedBox(height: 30),
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
                    print(snapshot.data!.docs.length);
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
                        var image = document['image'];
                        var isCheck = document['isCheck'];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: InkWell(
                            onTap: () {
                              print(document);
                              if (isCheck == 1) {
                                updateStudentAge(document.id, 0);
                              } else {
                                // Handle view class button press
                                updateStudentAge(document.id, 1);
                              }
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
                                                image: NetworkImage(
                                                  image,
                                                ),
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
                                              color: isCheck == 1
                                                  ? Color.fromARGB(
                                                      72, 219, 219, 219)
                                                  : Color.fromARGB(
                                                      71, 218, 49, 11),
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
                                              color: isCheck == 1
                                                  ? Color.fromARGB(
                                                      160, 28, 136, 224)
                                                  : Color.fromARGB(
                                                      71, 218, 49, 11),
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
              Center(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          Colors.grey), // You can customize the color and width
                  borderRadius: BorderRadius.circular(
                      8), // You can customize the border radius
                ),
                child: TextButton(
                  onPressed: () => {_showTimePicker(context)},
                  child: Text(
                    'Add Activity',
                    style: TextStyle(
                      color: Color(0xFF554994),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.06,
                    ),
                  ),
                ),
              ))
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
            switch (index) {
              case 0:
                // Navigate to Home
                break;
              case 1:
                // Navigate to Chat
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeacherChatPage()),
                );
                break;
              case 2:
                // Navigate to Profile
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TeacherProfilePage(
                            uid: user?.uid,
                          )),
                );
                break;
            }
          },
        ),
      ),
    );
  }

  void updateStudentAge(String documentId, int check) async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(documentId)
          .update({
        'isCheck': check,
        // Add more fields to update if needed
      });
      print('Document updated successfully!');
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      _uploadImage(File(video), context).then((videoUrl) {
        _saveActivity(videoUrl, context);
      });
      print('Selected Time: ${pickedTime.format(context)}');
    }
  }

  Future<String> _uploadImage(File videoFile, context) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('activity_video/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(videoFile);
      await uploadTask.whenComplete(() => null);
      String videoUrl = await storageReference.getDownloadURL();
      return videoUrl;
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'An error occurred while uploading your image!',
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      )..show();
      return '';
    }
  }

  Future<void> _saveActivity(String videoUrl, context) async {
    try {
      await FirebaseFirestore.instance.collection('activities').add({
        'videoUrl': videoUrl,
        'timestamp': Timestamp.now(),
        'user': user!.uid,
        // Add more fields as needed
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Activity Saved',
        desc: 'Your activity has been saved successfully!',
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      )..show();
    } catch (e) {
      print('Error saving activity: $e');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'An error occurred while saving your activity!',
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      )..show();
    }
  }
}
