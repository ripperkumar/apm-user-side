import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app_apm/AllScreens/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rider_app_apm/AllScreens/mainscreen.dart';
import 'package:rider_app_apm/AllScreens/registrationScreen.dart';

void main() async{
  WidgetsFlutterBinding;
  await Firebase.initializeApp();
  runApp(const MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apm rider app',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen:(context)=>RegistrationScreen(),
        LoginScreen.idScreen:(context)=>const LoginScreen(),
        MainScreen.idScreen:(context)=>const LoginScreen(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}

