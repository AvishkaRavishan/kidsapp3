import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_application_kids/TeacherProfile.dart';
import 'package:mobile_application_kids/teacherhome.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  File? _imageFile;
  String? _voiceFilePath;
  String? _username;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    fetchFullName(_user!.uid).then((fullName) {
      if (fullName != null) {
        _username = fullName;
      } else {
        print('No such document');
      }
    });
  }

  void _sendMessage() async {
    try {
      if (_textController.text.isNotEmpty ||
          _imageFile != null ||
          _voiceFilePath != null) {
        String message = _textController.text.trim();
        _textController.clear();

        String imageUrl = '';
        String voiceUrl = '';

        if (_imageFile != null) {
          imageUrl = await _uploadFile(_imageFile!);
        }

        if (_voiceFilePath != null) {
          voiceUrl = await _uploadFile(File(_voiceFilePath!));
        }
        CollectionReference ref =
            FirebaseFirestore.instance.collection('users');
        DocumentSnapshot snapshot = await ref.doc(_user!.uid).get();

        if (snapshot.exists) {
          _username = (snapshot.data() as Map<String, dynamic>)['fullName'];
        } else {
          return null;
        }

        await _firestore.collection('messages').add({
          'text': message,
          'createdAt': Timestamp.now(),
          'user': _user!.uid,
          'imageUrl': imageUrl,
          'voiceUrl': voiceUrl,
          'userName': _username
        });

        _imageFile = null;
        _voiceFilePath = null;
      }
    } catch (e, stackTrace) {
      print('Error sending message: $e');
      print('Stack trace: $stackTrace');
      // Handle the error gracefully, e.g., show a snackbar or display an error message
    }
  }

  Future<String> _uploadFile(File file) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('uploads/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => null);
    return await storageReference.getDownloadURL();
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
            child: Text('Chat',
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var message = snapshot.data!.docs[index];
                    bool isCurrentUser = message['user'] == _user!.uid;

                    // Perform null check before accessing properties using []
                    String? text = (message.data()
                        as Map<String, dynamic>)['text'] as String?;
                    String? imageUrl = (message.data()
                        as Map<String, dynamic>)['imageUrl'] as String?;
                    String? voiceUrl = (message.data()
                        as Map<String, dynamic>)['voiceUrl'] as String?;
                    String? __username = (message.data()
                        as Map<String, dynamic>)['userName'] as String?;

                    return MessageBubble(
                        message: text ?? '',
                        imageUrl: imageUrl,
                        voiceUrl: voiceUrl,
                        isCurrentUser: isCurrentUser,
                        userName: __username!);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () async {
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _imageFile = File(image.path);
                      });
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Send a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      
    );
  }

  Future<String?> getFullNameByUid(String uid) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snapshot = await ref.doc(uid).get();

    if (snapshot.exists) {
      return (snapshot.data() as Map<String, dynamic>)['fullName'];
    } else {
      return null;
    }
  }

  Future<String?> fetchFullName(String uid) async {
    String? fullName = await getFullNameByUid(_user!.uid);
    return fullName;
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String? imageUrl;
  final String? voiceUrl;
  final bool isCurrentUser;
  final String userName;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    this.imageUrl,
    this.voiceUrl,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isCurrentUser
                ? Color.fromARGB(36, 85, 193, 255)
                : const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (imageUrl != null &&
                  Uri.parse(imageUrl!)
                      .isAbsolute) // Check if imageUrl is not null and a valid network URL
                Image.network(
                  imageUrl!,
                  width: 200,
                ),
              if (message.isNotEmpty)
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              Text(
                userName,
                style: TextStyle(
                  color: Color.fromARGB(255, 29, 51, 243),
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
