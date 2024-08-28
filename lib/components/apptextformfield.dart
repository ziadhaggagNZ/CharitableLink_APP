import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  const AppTextField(
      {super.key, required this.hinttext, required this.mycontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 119, 33, 108)),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 108, 247, 70)),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        hintText: hinttext,
      ),
    );
  }
}
