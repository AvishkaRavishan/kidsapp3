import 'package:flutter/material.dart';

import 'ChatScreen.dart';

class TeacherChatPage extends StatefulWidget {
  @override
  _TeacherChatPageState createState() => _TeacherChatPageState();
}

class _TeacherChatPageState extends State<TeacherChatPage> {
  int _currentIndex = 1; // Set the default selected index to 'Chat'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatScreen())),
            child: Text('Chat')),
      ),
      body: ChatList(),
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
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle bottom navigation item tap
        },
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Replace with the actual number of chats
      itemBuilder: (context, index) {
        return ChatItem(
          profileImage:
              'lib/assets/profile_image.png', // Replace with the actual image path
          name: 'Student ${index + 1}',
          lastMessage: 'Hello, how are you?',
          time: '2:30 PM',
          onTap: () {
            // Handle chat item tap
          },
        );
      },
    );
  }
}

class ChatItem extends StatelessWidget {
  final String profileImage;
  final String name;
  final String lastMessage;
  final String time;
  final VoidCallback onTap;

  const ChatItem({
    required this.profileImage,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImage),
      ),
      title: Text(name),
      subtitle: Text(lastMessage),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time),
          SizedBox(height: 5),
          // Add additional indicators (e.g., unread message count) if needed
        ],
      ),
    );
  }
}
