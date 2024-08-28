import 'package:charitablelink/sign_options/signup_aidprovider.dart';
import 'package:charitablelink/sign_options/signup_charity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}


class _SignupState extends State<Signup> {

  int index=0;
  List<Widget> listwidget =
  [
    signupprovider(),
    signupcharity(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        iconSize: 40,
        selectedItemColor: Color.fromARGB(255, 119, 33, 108),
        selectedFontSize: 20,
        unselectedFontSize: 15,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.man),label: "aid provider"),
        BottomNavigationBarItem(icon: Icon(Icons.home_work_outlined),label: "charity"),
      ]),
      body: listwidget.elementAt(index),
    );
  }
}