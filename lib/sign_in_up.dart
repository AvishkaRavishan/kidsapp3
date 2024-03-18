import 'package:flutter/material.dart';
import 'package:mobile_application_kids/p_or_t.dart';
import 'package:mobile_application_kids/parentSignUp.dart';
import 'package:mobile_application_kids/teachersignup.dart';

import 'p_or_t_s.dart';

class SignInUpPage extends StatelessWidget {
  const SignInUpPage({Key? key, required this.backgroundColor})
      : super(key: key);

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'lib/assets/signinup.png',
                      width: 290,
                      height: 460,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the signup page (TeacherSignupPage)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParentTeacherSignUpPage(
                            backgroundColor: backgroundColor,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color.fromARGB(255, 96, 188, 99),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the sign in page (ParentTeacherPage)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParentTeacherPage(
                            backgroundColor: backgroundColor,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
