import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/controllers/user_controller.dart';
import 'package:social_app/views/screens/login_screen.dart';
import 'package:social_app/views/screens/social_layout.dart';
// AIzaSyA36SoPQP5-8d4u9ocJgL1n1NZrutGF4SQ

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserController.getUserData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  Widget _getHomePage() {
    if (FirebaseAuth.instance.currentUser != null) {
      return SocialLayout();
    } else
      return LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        primaryColor: k_primiryColor,
        fontFamily: "IBM",
        appBarTheme: AppBarTheme(
          backgroundColor: k_primiryColor,
          elevation: 0.0,
          centerTitle: false,
        ),
        textTheme: TextTheme(
          headline3: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headline4: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          headline5: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
          headline6: TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: _getHomePage(),
    );
  }
}
