import 'package:book_hero/Screens/alphabet_screen.dart';
import 'package:book_hero/constants/AppStrings.dart';
import 'package:book_hero/constants/Constants.dart';
import 'package:book_hero/models/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Subscription_page extends StatefulWidget {
  const Subscription_page({Key? key}) : super(key: key);
  static const String idScreen = "Subscription screen";
  @override
  _Subscription_pageState createState() => _Subscription_pageState();
}

class _Subscription_pageState extends State<Subscription_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow[400],
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bookhero.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        AppStrings.appName,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PretendardBold'),
                      ),
                      SizedBox(height: 5),
                      Text(
                        AppStrings.appTitle,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PretendardBold'),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          AppStrings.appTitleSub,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Pretendard'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: IconButton(
                            icon: Image.asset(
                              'assets/btn_google_n.png',
                            ),
                            onPressed: () {
                              final provider = Provider.of<GoogleSignInProvider>(
                                  context,
                                  listen: false);
                              provider.googleLogin();
                            },
                          )
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          "\$0.99/mo after trial ends",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Pretendard'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(child: Container()),
                      Divider(
                        height: 10, // You can adjust the height of the separator here
                        thickness: 1, // You can adjust the thickness of the separator here
                        color: Colors.grey[400], // You can set the color of the separator here
                      ),

                      Container(
                        height: 40,
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Restore Purchase", style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Pretendard'),
                                textAlign: TextAlign.center,),
                              SizedBox(
                                height: 12,
                                child: VerticalDivider(
                                  // You can adjust the height of the separator here
                                  thickness: 1, // You can adjust the thickness of the separator here
                                  color: Colors.grey[400], // You can set the color of the separator here
                                ),
                              ),
                              GestureDetector(
                                onTap: ()
                                {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context){
                                    return SafeArea(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 30,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15.0),
                                                  child: Text('Terms of Service',style: TextStyle(fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Pretendard'),),
                                                ),
                                                Spacer(),
                                                IconButton(onPressed: (){Navigator.pop(context);},
                                                    icon: FaIcon(FontAwesomeIcons.close,size: 30,))
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0,right: 10),
                                              child: Text(AppStrings.privacyPolicy,style: TextStyle(
                                                  fontFamily: 'Pretendard',fontSize: 16,
                                              ),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: Text(" Terms of service", style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Pretendard'),
                                  textAlign: TextAlign.center,),
                              ),
                              SizedBox(
                                height: 12,
                                child: VerticalDivider(
                                // You can adjust the height of the separator here
                                  thickness: 1, // You can adjust the thickness of the separator here
                                  color: Colors.grey[400], // You can set the color of the separator here
                                ),
                              ),
                              GestureDetector(
                                onTap: ()
                                {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context){
                                        return SafeArea(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 30,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [

                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15.0),
                                                      child: Text('Privacy Policy',style: TextStyle(fontSize: 24,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Pretendard'),),
                                                    ),
                                                    Spacer(),
                                                    IconButton(onPressed: (){Navigator.pop(context);},
                                                        icon: FaIcon(FontAwesomeIcons.close,size: 30,))
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15.0,right: 10),
                                                  child: Text(AppStrings.toS,style: TextStyle(
                                                    fontFamily: 'Pretendard',fontSize: 16,
                                                  ),),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Text("Privacy Policy", style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Pretendard'),
                                  textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


