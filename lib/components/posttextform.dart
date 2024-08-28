import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class postTextField extends StatelessWidget {
  final TextEditingController mycontroller ;
  final String hintText ;
  const postTextField({super.key, required this.mycontroller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
     // margin: EdgeInsets.symmetric(horizontal:  10),
      child: TextFormField(
        controller: mycontroller,
        textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    
                    enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Color.fromARGB(255, 119, 33, 108))),
                    focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Color.fromARGB(255, 108, 247, 70))),
                   hintText: hintText ,
                      ),
                      ),
    );
  }
}