import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ParentSignupPage extends StatefulWidget {
  const ParentSignupPage({Key? key}) : super(key: key);

  @override
  _ParentSignupPageState createState() => _ParentSignupPageState();
}

class _ParentSignupPageState extends State<ParentSignupPage> {
  // TextEditingController for text input fields
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // TextEditingController schoolNameController = TextEditingController();
  // TextEditingController enrolmentCapacityController = TextEditingController();
  // TextEditingController countryController = TextEditingController();
  // TextEditingController stateRegionController = TextEditingController();

  bool agreeTermsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Signup'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'lib/assets/tsignup1.png',
              width: 240,
              height: 270,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextInputWithIcon(
                    controller: fullNameController,
                    labelText: 'Full Name',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 10),
                  _buildTextInputWithIcon(
                    controller: emailController,
                    labelText: 'Email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 10),
                  _buildTextInputWithIcon(
                    controller: phoneNumberController,
                    labelText: 'Phone Number',
                    icon: Icons.phone,
                  ),
                  const SizedBox(height: 10),
                  _buildTextInputWithIcon(
                    controller: passwordController,
                    labelText: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Logic to navigate to the next page with additional information

                      signUp(emailController.text, passwordController.text,
                          'parent', context);
                    },
                    child: Text('Finish'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInputWithIcon({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[200], // Light gray background color
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent), // No border color when focused
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent), // No border color when not focused
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void signUp(String email, String password, String rool, context) async {
    CircularProgressIndicator();

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore(email, rool, context)})
        .catchError((e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: ' error',
        btnOkOnPress: () {},
      )..show();
    });
  }

  postDetailsToFirestore(String email, String rool, context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;

    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    print("user!.uid == : " + emailController.text);
    ref.doc(user!.uid).set({
      "fullName": fullNameController.text,
      'email': emailController.text,
      'phoneNo': phoneNumberController.text,
      "agreeTermsAndConditions": agreeTermsAndConditions,
      'rool': rool
    });
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Successfully Created',
      desc: ' Go to Login page',
      btnOkOnPress: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(
                      backgroundColor: Color.fromARGB(255, 0, 183, 255),
                    )));
      },
    )..show();
  }
}
