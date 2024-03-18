import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({required this.classname});
  final String classname;

  @override
  State<AddStudentPage> createState() => _AddStudentState(classname);
}

class _AddStudentState extends State<AddStudentPage> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  //Bio Part
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _sexController = TextEditingController();

  //Medicine Part
  TextEditingController _doctornameController = TextEditingController();
  TextEditingController _doctorphoneController = TextEditingController();
  TextEditingController _allergiesController = TextEditingController();
  TextEditingController _medicineController = TextEditingController();
  TextEditingController _specailnotController = TextEditingController();
  bool _specialNeedsYes = false;
  bool _specialNeedsNo = false;

  //Contact Part
  TextEditingController _parentnameController = TextEditingController();
  TextEditingController _parentphoneController = TextEditingController();
  TextEditingController _parentemailController = TextEditingController();

  //Adress Part
  TextEditingController _adressline1Controller = TextEditingController();
  TextEditingController _adressline2Controller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  //imagepicker
  ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  String classname;

  _AddStudentState(String classname) : this.classname = classname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press if needed
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add Kid  ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the content vertically
                children: [
                  GestureDetector(
                    onTap: () async {
                      XFile? image = await _imagePicker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 50,
                      );
                      setState(() {
                        _selectedImage = image;
                      });
                    },
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: _selectedImage != null
                          ? Image.file(File(_selectedImage!.path)).image
                          : AssetImage('lib/assets/classlogo.png'),
                    ),
                  ),

                  //Bio Part
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          ' Bio',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF22215B),
                          ),
                        ),
                      ),
                      // Add your other widgets here
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      style: TextStyle(fontSize: 14.0, fontFamily: 'Poppins'),
                      controller: _firstnameController,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.person,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _lastnameController,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.person,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0), // Add border here
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _birthdayController,
                      decoration: InputDecoration(
                        hintText: 'Birthday',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.cake,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _sexController,
                      decoration: InputDecoration(
                        hintText: 'Male/Female',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.people,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0), // Add border here
                      ),
                    ),
                  ),

                  //Medicine Part

                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          ' Medicine',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF22215B),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _doctornameController,
                      decoration: InputDecoration(
                        hintText: 'Doctor Name',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.person,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _doctorphoneController,
                      decoration: InputDecoration(
                        hintText: 'Doctor Phone Number',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.phone,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _allergiesController,
                      decoration: InputDecoration(
                        hintText: 'Allergies',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.coronavirus_sharp,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _medicineController,
                      decoration: InputDecoration(
                        hintText: 'Medicine',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.medication_outlined,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            ' Special Needs Child',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(247, 251, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text('Yes'),
                        Checkbox(
                          value: _specialNeedsYes,
                          onChanged: (bool? value) {
                            setState(() {
                              _specialNeedsYes = value ?? false;
                              if (_specialNeedsYes) {
                                _specialNeedsNo =
                                    false; // Unselect "No" if "Yes" is selected
                              }
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        Text('No'),
                        Checkbox(
                          value: _specialNeedsNo,
                          onChanged: (bool? value) {
                            setState(() {
                              _specialNeedsNo = value ?? false;
                              if (_specialNeedsNo) {
                                _specialNeedsYes =
                                    false; // Unselect "Yes" if "No" is selected
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  //Contact Part

                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          ' Contact',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF22215B),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _parentnameController,
                      decoration: InputDecoration(
                        hintText: 'Parent Name',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.person,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _parentphoneController,
                      decoration: InputDecoration(
                        hintText: 'Parent Phone Number',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.phone,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _parentemailController,
                      decoration: InputDecoration(
                        hintText: 'Parent Email',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.email,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  //Adress Part

                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          ' Adress',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF22215B),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _adressline1Controller,
                      decoration: InputDecoration(
                        hintText: 'Adress Line 1',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.location_on_outlined,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _adressline2Controller,
                      decoration: InputDecoration(
                        hintText: 'Adress Line 2',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.location_on_outlined,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        hintText: 'City',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.location_city_sharp,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _zipController,
                      decoration: InputDecoration(
                        hintText: 'Zip/Postal Code',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.location_searching,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _countryController,
                      decoration: InputDecoration(
                        hintText: 'Country',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.location_city_rounded,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 55.0,
                    child: TextField(
                      controller: _stateController,
                      decoration: InputDecoration(
                        hintText: 'State/Region',
                        filled: true,
                        fillColor: Color.fromARGB(107, 196, 196, 196),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // Remove border color
                        ),
                        suffixIcon: Icon(Icons.location_city_sharp,
                            size: 23.0, color: Color.fromARGB(132, 12, 12, 12)),
                        hintStyle: TextStyle(fontSize: 14.0),
                        // fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          if (Image == null) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Please Select Image',
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                            )..show();
                          } else {
                            // Handle signup logic here
                            String firstname = _firstnameController.text;
                            String lastname = _lastnameController.text;
                            String birthday = _birthdayController.text;
                            String sex = _sexController.text;

                            //Medicine Part
                            String doctorname = _doctornameController.text;
                            String doctorphone = _doctorphoneController.text;
                            String allergies = _allergiesController.text;
                            String medicine = _medicineController.text;

                            //Contact Part
                            String parentname = _parentnameController.text;
                            String parentphone = _parentphoneController.text;
                            String parentemail = _parentemailController.text;

                            //Adress Part
                            String adressline1 = _adressline1Controller.text;
                            String adressline2 = _adressline2Controller.text;
                            String city = _cityController.text;
                            String zip = _zipController.text;
                            String country = _countryController.text;
                            String state = _stateController.text;
                            var imageName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            var storageRef = FirebaseStorage.instance
                                .ref()
                                .child('student_images/$imageName.jpg');
                            var uploadTask;
                            var downloadUrl = "";
                            if (_selectedImage != null) {
                              uploadTask = storageRef
                                  .putFile(File(_selectedImage!.path));

                              downloadUrl =
                                  await (await uploadTask).ref.getDownloadURL();
                            }

                            // You can perform signup/authentication logic here
                            postDetailsToFirestore(
                                downloadUrl,
                                firstname,
                                lastname,
                                sex,
                                birthday,
                                doctorname,
                                doctorphone,
                                allergies,
                                medicine,
                                parentname,
                                parentphone,
                                parentemail,
                                adressline1,
                                adressline2,
                                city,
                                zip,
                                country,
                                state,
                                classname,
                                context);
                          }
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle signup logic here
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade200),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore(
      String image,
      String firstname,
      String lastname,
      String sex,
      String birthday,
      String doctorname,
      String doctorphone,
      String allergies,
      String medicine,
      String parentname,
      String parentphone,
      String parentemail,
      String adressline1,
      String adressline2,
      String city,
      String zip,
      String country,
      String state,
      String classname,
      context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;

    CollectionReference ref = FirebaseFirestore.instance.collection('students');

    ref.doc().set({
      "Firstname": firstname,
      "Lastname": lastname,
      "Sex": sex,
      "Birthday": birthday,
      "Doctorname": doctorname,
      "Doctorphone": doctorphone,
      "Allergies": allergies,
      "Medicine": medicine,
      "Parentname": parentname,
      "Parentphone": parentphone,
      "Parentemail": parentemail,
      "Adressline1": adressline1,
      "Adressline2": adressline2,
      "City": city,
      "Zip": zip,
      "Country": country,
      "State": state,
      "user": user!.uid,
      "image": image,
      "className": classname,
      "isCheck": 0,
      "role": 'Student'
    });
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Successfully Created',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    )..show();
  }
}
