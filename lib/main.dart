import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_kids/sign_in_up.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 255, 255, 255)),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      home: const MyHomePage(
        title: '',
        backgroundColor: Color.fromARGB(255, 0, 183, 255),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key, required this.title, required this.backgroundColor})
      : super(key: key);

  final String title;
  final Color backgroundColor;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double scaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 700), (timer) {
      setState(() {
        // Toggle between zoom in and zoom out
        scaleFactor = scaleFactor == 1.0 ? 1.05 : 1.0;
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignInUpPage(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255))),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        color: widget.backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInUpPage(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255))),
                      );
                    },
                    child: Transform.scale(
                      scale: scaleFactor,
                      child: Image.asset(
                        'lib/assets/landingimg.png',
                        width: 310,
                        height: 370,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Welcome little explorer!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Text(
                  "Let's dive into a world of fun and \nlearning together!",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
