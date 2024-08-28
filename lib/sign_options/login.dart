//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charitablelink/components/apptextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Container(
              height: 450,
              width: 450,
              child: Image.asset(
                "images/hart.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
              child: Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: AppTextField(
              hinttext: "email",
              mycontroller: email,
            ),
          )),
          Center(
              child: Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: AppTextField(
              hinttext: "password",
              mycontroller: password,
            ),
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: Row(
              children: [
                Text(
                  "Don't have an account ",
                  style: TextStyle(
                      color: Color.fromARGB(255, 50, 234, 248)),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("signup");
                    },
                    child: Text(
                      "? Sign up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 119, 33, 108),
                      ),
                    ))
              ],
            ),
          ),
          Center(
            child: Container(
              width: 410,
              height: 113,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: MaterialButton(
                  child: Text(
                    "Log in",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      if (email.text == "" || password.text == "") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'email or password',
                          desc: 'email or password is empty',
                          btnOkOnPress: () {},
                        ).show();
                      }
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email.text, password: password.text);
                      if (credential.user!.emailVerified) {
                        Navigator.of(context).pushReplacementNamed("homepage");
                      }
                      else
                      {
                         AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'need verify',
                          desc: 'please verify your mail',
                          btnOkOnPress: () {},
                        ).show();
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-credential') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'email or password',
                          desc: 'check your email or password',
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }
                  },
                  color: Color.fromARGB(255, 119, 33, 108),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      )),
            ),
          ),
        ],
      ),
    ));
  }
}
