import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app_apm/AllScreens/iceContactPage.dart';
import 'package:rider_app_apm/AllScreens/iceScreen.dart';
import 'package:rider_app_apm/AllScreens/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rider_app_apm/AllScreens/mainscreen.dart';
import 'package:rider_app_apm/AllScreens/registrationScreen.dart';

import 'package:rider_app_apm/AllScreens/userDetail.dart';
import 'package:rider_app_apm/dataHandler/appData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>AppData(),
      child: MaterialApp(
        title: 'Apm rider app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MainScreen.idScreen,
        routes: {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
          UserDetail.idScreen: (context) => UserDetail(),
          IceContacts.idScreen:(context) => IceContacts(),
          IceScreen.idScreen:(context)=>IceScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
