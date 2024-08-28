import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: camel_case_types
class aidprovider_homepage extends StatefulWidget {
  const aidprovider_homepage({super.key});

  @override
  State<aidprovider_homepage> createState() => _aidprovider_homepageState();
}

// ignore: camel_case_types
class _aidprovider_homepageState extends State<aidprovider_homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(children: [
        Container(height: 200,),
        IconButton(onPressed: ()
        async{
              GoogleSignIn googleSignIn =GoogleSignIn();
              if(googleSignIn.isSignedIn() == true)
              {
                googleSignIn.disconnect();
              }
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);

        }, icon: Icon(Icons.exit_to_app),),
        Text("aid provider home page"),
      ],)
    );
  }
}