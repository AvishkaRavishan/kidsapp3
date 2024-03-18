import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class TeacherSignupPage extends StatefulWidget {
  const TeacherSignupPage({Key? key}) : super(key: key);

  @override
  _TeacherSignupPageState createState() => _TeacherSignupPageState();
}

class _TeacherSignupPageState extends State<TeacherSignupPage> {
  // TextEditingController for text input fields
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
        title: Text('Teacher Signup'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdditionalInfoPage(
                            fullNameController: fullNameController,
                            emailController: emailController,
                            phoneNumberController: phoneNumberController,
                            passwordController: passwordController,
                            agreeTermsAndConditions: agreeTermsAndConditions,
                          ),
                        ),
                      );
                    },
                    child: Text('Next'),
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
}

class AdditionalInfoPage extends StatelessWidget {
  AdditionalInfoPage(
      {Key? key,
      required this.fullNameController,
      required this.emailController,
      required this.phoneNumberController,
      required this.passwordController,
      required this.agreeTermsAndConditions})
      : super(key: key);

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;

  TextEditingController schoolNameController = TextEditingController();
  TextEditingController enrolmentCapacityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateRegionController = TextEditingController();
  final bool agreeTermsAndConditions;
  var rool = "teacher";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextInputWithIcon(
              controller: schoolNameController,
              labelText: 'School Name',
              icon: Icons.school,
            ),
            const SizedBox(height: 10),
            _buildTextInputWithIcon(
              controller: enrolmentCapacityController,
              labelText: 'Enrolment Capacity',
              icon: Icons.people,
            ),
            const SizedBox(height: 10),
            _buildTextInputWithIcon(
              controller: countryController,
              labelText: 'Country',
              icon: Icons.location_on,
            ),
            const SizedBox(height: 10),
            _buildTextInputWithIcon(
              controller: stateRegionController,
              labelText: 'State/Region',
              icon: Icons.location_city,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // Checkbox(
                //   value: agreeTermsAndConditions,
                //   onChanged: (value) {
                //     // Logic to update the checkbox value
                //     setState(() {
                //       agreeTermsAndConditions = value!;
                //     });
                //   },
                // ),
                Text(
                  'By checking the box you agree to our Terms and Conditions.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to finish the teacher registration
                signUp(emailController.text, passwordController.text, rool,
                    context);
              },
              child: Text('Finish'),
            ),
          ],
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
      "school": schoolNameController.text,
      "enrolmentCapacity": enrolmentCapacityController.text,
      "country": countryController.text,
      "state": stateRegionController.text,
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

  Widget _buildTextInputWithIcon({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
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
}
