import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 
class KidsReportPage extends StatefulWidget {
  String id;
  KidsReportPage({required this.id});
 
  @override
  _KidsReportPageState createState() => _KidsReportPageState(id: id);
}
 
class _KidsReportPageState extends State<KidsReportPage> {
  String id;
  _KidsReportPageState({required this.id});
 
  List<String> dropdownValues = ['Select', '1', '2', '3', '4', '5'];
 
  Map<String, String?> understandingDropdownMap = {
    'Understanding commands': 'Select',
    'Answer questions': 'Select',
    'Keeping eye contact': 'Select',
    'Following rules': 'Select',
  };
 
  Map<String, String?> movementsDropdownMap = {
    'Motor activities': 'Select',
    'Correct posture': 'Select',
  };
 
  Map<String, String?> manipulatingDropdownMap = {
    'Can build/create new things': 'Select',
    'Knows how to handle accessories': 'Select',
  };
 
  Map<String, String?> socializingDropdownMap = {
    'Play with groups': 'Select',
    'Help each other': 'Select',
    'Friendly towards peers': 'Select',
    'Close to teacher': 'Select',
  };
 
  Map<String, String?> speechDropdownMap = {
    'Communicate well': 'Select',
    'Like singing': 'Select',
  };
 
  Map<String, String?> recognitionDropdownMap = {
    'Can express with pictures and words': 'Select',
    'Identify shapes': 'Select',
    'Knows Primary colors.': 'Select',
    'Identify basic objects in the environment': 'Select',
  };
 
  Map<String, String?> habitsDropdownMap = {
    'Organized': 'Select',
    'Have good eating habits': 'Select',
    'Taking care of own needs': 'Select',
  };
 
  Map<String, String?> personalHygieneDropdownMap = {
    'Stay clean': 'Select',
    'Keep the workplace and environment clean': 'Select',
  };
 
  Map<String, String?> personalityDropdownMap = {
    'Act according to the situation': 'Select',
    'Finish allocated work': 'Select',
    'More active': 'Select',
    'Less active': 'Select',
  };
 
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16),
            child: Text('Student Report',
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  _buildDropdownSection(
                    title: 'Understanding',
                    dropdownMap: understandingDropdownMap,
                  ),
                  SizedBox(height: 20),
                  _buildDropdownSection(
                    title: 'Movements',
                    dropdownMap: movementsDropdownMap,
                  ),
                  SizedBox(height: 20),
                  _buildDropdownSection(
                    title: 'Manipulating',
                    dropdownMap: manipulatingDropdownMap,
                  ),
                  SizedBox(height: 20),
                  _buildDropdownSection(
                    title: 'Socializing',
                    dropdownMap: socializingDropdownMap,
                  ),
                  SizedBox(height: 20),
                  _buildDropdownSection(
                    title: 'Speech',
                    dropdownMap: speechDropdownMap,
                  ),
                  SizedBox(height: 20),
                  _buildDropdownSection(
                    title: 'Recognition',
                    dropdownMap: recognitionDropdownMap,
                  ),
                  SizedBox(height: 20),
                  _buildDropdownSection(
                    title: 'Habits',
                    dropdownMap: habitsDropdownMap,
                  ),
                  SizedBox(height: 20),
                  _buildDropdownSection(
                    title: 'Personal Hygiene',
                    dropdownMap: personalHygieneDropdownMap,
                  ),
                  SizedBox(height: 20),
                  _buildDropdownSection(
                    title: 'Personality',
                    dropdownMap: personalityDropdownMap,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              postDetailsToFirestore(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 48, 206, 53),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Save',
                              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  Widget _buildDropdownSection({
  required String title,
  required Map<String, String?> dropdownMap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ...dropdownMap.keys.map((String key) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  key,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DropdownButton<String>(
                    value: dropdownMap[key],
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 1,
                      color: Colors.green,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownMap[key] = value;
                      });
                    },
                    items: dropdownValues.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ],
  );
}
 
 
 
  postDetailsToFirestore(context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
 
    CollectionReference ref =
        FirebaseFirestore.instance.collection('reports');
 
    // Constructing the data to be saved
    Map<String, dynamic> data = {};
    understandingDropdownMap.forEach((key, value) {
      data[key] = value;
    });
    movementsDropdownMap.forEach((key, value) {
      data[key] = value;
    });
    manipulatingDropdownMap.forEach((key, value) {
      data[key] = value;
    });
    socializingDropdownMap.forEach((key, value) {
      data[key] = value;
    });
    speechDropdownMap.forEach((key, value) {
      data[key] = value;
    });
    recognitionDropdownMap.forEach((key, value) {
      data[key] = value;
    });
    habitsDropdownMap.forEach((key, value) {
      data[key] = value;
    });
    personalHygieneDropdownMap.forEach((key, value) {
      data[key] = value;
    });
    personalityDropdownMap.forEach((key, value) {
      data[key] = value;
    });
    data['sId'] = id;
 
    await ref.doc(id).set(data);
 
    AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.rightSlide,
    title: 'Successfully Created',
    btnOkOnPress: () {
      // Navigate back to the previous page
      Navigator.pop(context);
    },
  )..show();
}
}