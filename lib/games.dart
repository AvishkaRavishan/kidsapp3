import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  final List<Map<String, String>> gameData = [
    {'game': 'Game 1', 'description': 'Description for Game 1'},
    {'game': 'Game 2', 'description': 'Description for Game 2'},
    // add list
  ];

  final String commonImagePath = 'assets/act_photo.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'My Games',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gameData.length,
              itemBuilder: (context, index) {
                var game = gameData[index];
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Container(
                      width: 50, 
                      height: 50,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(commonImagePath),
                      ),
                    ),
                    title: Text(
                      game['game'] ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(game['description'] ?? ''),
                  ),
                );
              },
            ),
          ),
        ],
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
            icon: Icon(Icons.games),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color(0xFF7A1FA0),
        unselectedItemColor: Color(0xFFA9ABAD),
        selectedLabelStyle: TextStyle(color: Color(0xFF7A1FA0)),
        unselectedLabelStyle: TextStyle(color: Color.fromARGB(0, 197, 16, 16)),
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to Home
              // Replace the code below with your home navigation logic
              // Navigator.push(
              //   // context,
              //   // MaterialPageRoute(builder: (context) => AddClassroom()), 
              // );
              break;
            case 1:
              // Navigate to Chat
              // Navigator.push(
              //   // context,
              //   // MaterialPageRoute(builder: (context) => ChatScreen()),
              // );
              break;
            case 2:
              // Already on Games Page
              break;
            case 3:
              // Navigate to Profile
              // Navigator.push(
              //   // context,
              //   // MaterialPageRoute(builder: (context) => TeacherProfile()),
              // );
              break;
          }
        },
      ),
    );
  }
}
