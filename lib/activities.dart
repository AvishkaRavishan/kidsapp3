import 'package:flutter/material.dart';
import 'package:mobile_application_kids/ChatScreen.dart';
import 'package:mobile_application_kids/TeacherProfile.dart';
import 'package:mobile_application_kids/teacherhome.dart';

class ActivitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities  '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CameraActivityBox(
                    title: 'Photo',
                    icon: Icons.photo,
                    cameraType: CameraType.photo,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CameraActivityBox(
                    title: 'Video',
                    icon: Icons.video_library,
                    cameraType: CameraType.video,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ActivityBox(
                    title: 'Coloring Book',
                    icon: Icons.group,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ActivityBox(
                    title: 'Whiteboard',
                    icon: Icons.border_color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ActivityBox(
                    title: 'Environment',
                    icon: Icons.child_care,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const ActivityBox({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CameraType { photo, video }

class CameraActivityBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final CameraType cameraType;

  const CameraActivityBox({
    Key? key,
    required this.title,
    required this.icon,
    required this.cameraType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActivityBox(
      title: title,
      icon: icon,
      onTap: () {
        // Navigate to the camera screen based on the camera type
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraScreen(cameraType: cameraType),
          ),
        );
      },
    );
  }
}

class CameraScreen extends StatelessWidget {
  final CameraType cameraType;

  const CameraScreen({Key? key, required this.cameraType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your camera screen UI here
    return Scaffold(
      appBar: AppBar(
        title: Text(
            cameraType == CameraType.photo ? 'Take Photo' : 'Record Video'),
      ),
      body: Center(
        child: Text('Camera Screen Placeholder'),
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
                var user;
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
}