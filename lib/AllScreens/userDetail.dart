import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rider_app_apm/AllScreens/addICE_contacts.dart';
import 'package:rider_app_apm/AllScreens/multi_ice_contact_form_widget.dart';
import 'package:rider_app_apm/Assistants/assistantMethods.dart';
import '../main.dart';
import 'configMaps.dart';

class UserDetail extends StatefulWidget {
  static const String idScreen = "User detail";

  UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  TextEditingController bloodTextEditingController = TextEditingController();

  TextEditingController birthdayTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController alterPhoneTextEditingController =
      TextEditingController();
  TextEditingController tempAddressTextEditingController =
      TextEditingController();
  TextEditingController permaAddressTextEditingController =
      TextEditingController();
  @override
  void initState() {
    birthdayTextEditingController.text =
        ""; //set the initial value of text field
    super.initState();
  }

  var occupation = [
    'Student',
    'Professional',
    'Business',
    'Doctor',
    'Nurse',
    'other',
  ];
  var modeOfTransort = [
    'I take metro Mostly',
    'I ride my bike ',
    'I mostly rent a bike',
    'I take Cab/Auto',
    'I drive my Car',
    'I have chauffer',
  ];
  String occupationDropDown = "Student";
  String modeofTransportDropDown = "I take metro Mostly";

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 1.0,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage("images/apm_logo.png"),
                  height: 75,
                  width: 100,
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "User Detail",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bolt"),
                textAlign: TextAlign.center,
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: bloodTextEditingController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter blood type";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Blood Group",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        TextField(
                          controller: birthdayTextEditingController,
                          //editing controller of this TextField
                          decoration: const InputDecoration(
                            labelText: "Date of Birth",
                            suffixIcon: Icon(Icons.calendar_today),
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                birthdayTextEditingController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter phone no.";
                            }
                            return null;
                          },
                          controller: phoneTextEditingController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "phone no.",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter alternate phone number";
                            }
                            return null;
                          },
                          controller: alterPhoneTextEditingController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Alternate Phone no.",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter temporary address ";
                            }
                            return null;
                          },
                          controller: tempAddressTextEditingController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: "Temp Address",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter permanent address";
                            }
                            return null;
                          },
                          controller: permaAddressTextEditingController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: "Permanent address",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton(
                              value: occupationDropDown,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: occupation.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  occupationDropDown = newValue!;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 25.0,
                            ),
                            DropdownButton(
                              value: modeofTransportDropDown,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: modeOfTransort.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  modeofTransportDropDown = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                firebaseUser = FirebaseAuth.instance.currentUser;
                                userRef.child(firebaseUser!.uid).update({
                                  "blood group": bloodTextEditingController.text
                                      .trim(),

                                  "birthday": birthdayTextEditingController.text
                                      .trim(),

                                  "phone no": phoneTextEditingController.text
                                      .trim(),

                                  "alternate phone no": alterPhoneTextEditingController
                                      .text.trim(),
                                  "temp address": tempAddressTextEditingController
                                      .text.trim(),
                                  "permanent address": permaAddressTextEditingController
                                      .text.trim(),
                                  "occupation": occupationDropDown,
                                  "mode of transport": modeofTransportDropDown,
                                });
                                Navigator.pushNamedAndRemoveUntil(context,
                                    MultiContactFormWidget.idScreen, (route) => false);
                              }
                            },
                            child: const SizedBox(
                              height: 50.0,
                              child: Center(
                                  child: Text(
                                "Next ",
                                style: TextStyle(
                                    fontSize: 18.0, fontFamily: "Brand Bold"),
                              )),
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //TOAST FUNCTION
  void displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
