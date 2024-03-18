import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/teacherhome.dart';

class AddClassroomPage extends StatefulWidget {
  @override
  _AddClassroomPageState createState() => _AddClassroomPageState();
}

final _formkey = GlobalKey<FormState>();
final _auth = FirebaseAuth.instance;

class _AddClassroomPageState extends State<AddClassroomPage> {
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController roomCapacityController = TextEditingController();
  final TextEditingController ratioController = TextEditingController();

  final TextStyle poppinsTextStyle = TextStyle(
    fontFamily: 'Poppins',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Classroom  '),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/addclassroom.png',
                  height: 260,
                  width: 340,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: classNameController,
                  decoration: InputDecoration(
                    labelText: 'Classroom Name',
                    prefixIcon: Icon(Icons.school), // Classroom icon
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: roomCapacityController,
                  decoration: InputDecoration(
                    labelText: 'Room Capacity',
                    prefixIcon: Icon(Icons.people), // People icon
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: ratioController,
                  decoration: InputDecoration(
                    labelText: 'Student to Staff Ratio',
                    prefixIcon: Icon(Icons.numbers), // Your ratio icon
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Container(
                  height: 48.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    color:  Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      postDetailsToFirestore(context);
                    },
                    child: Text(
                      'Create Classroom',
                      style: poppinsTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore(context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;

    CollectionReference ref =
        FirebaseFirestore.instance.collection('classroom');
    print("class == : " + classNameController.text);
    ref.doc(classNameController.text).set({
      "className": classNameController.text,
      'roomCapacity': roomCapacityController.text,
      'ratio': ratioController.text,
      'userId': user!.uid,
    });
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Successfully Created',
      desc: ' Go to Home page',
      btnOkOnPress: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TeacherHomePage()));
      },
    )..show();
  }
}
