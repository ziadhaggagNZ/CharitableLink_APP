//import 'package:charitablelink/auth/login.dart';
//import 'package:charitablelink/auth/signup.dart';
import 'package:charitablelink/aidprovider/aidprovider_homepage.dart';
import 'package:charitablelink/needy/Add_needy.dart';
import 'package:charitablelink/needy/needy_helps_page.dart';
import 'package:charitablelink/needy/needy_info.dart';
//import 'package:charitablelink/posts/edit_post.dart';
import 'package:charitablelink/posts/posts_page.dart';
import 'package:charitablelink/sign_options/login.dart';
import 'package:charitablelink/sign_options/signup.dart';
import 'package:charitablelink/charity/charity_homepage.dart';
import 'package:charitablelink/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:charitablelink/auth/signup_options/signup_charity.dart';
//import 'package:charitablelink/auth/signup_options/signup_aidprovider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}


class MyApp extends StatefulWidget{

const MyApp({super.key});

@override
State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {


  

@override
  void initState() {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home://postspage(),
      FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified ? homepage() : login(),
      routes: {
        "login" : (context) => login(),
        "signup" : (context) => Signup(),
        "homepage" : (context) => homepage(),
        "aidproviderhomepage" : (context) => aidprovider_homepage(),
        "charityhomepage" : (context) => charity_homepage(),
        "postpage" : (context) => postspage(),
        "addneedy" : (context) => AddNeedy(),
        "needyinfo" : (context) => needyinfo(),
        "needyhelpspage" : (context) => needy_helps_page(),

              },
    );
  }
}










