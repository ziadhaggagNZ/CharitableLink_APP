import 'package:charitablelink/components/apptextformfield.dart';
import 'package:charitablelink/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ediitpost extends StatelessWidget {
  final int i;
   ediitpost({super.key, required this.i});

 TextEditingController editingController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Container(height: 200,),
      AppTextField(hinttext: "edit", mycontroller: editingController),
       Container(
                                width: 180,
                                height: 113,
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 50),
                                child: MaterialButton(
                                    child: Text(
                                      "Edit post",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    textColor:
                                        Colors.white,
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                .collection("charity")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("posts").doc(data_posts_edit[i].id).update({"post" : editingController.text});
                                Navigator.of(context).pushNamedAndRemoveUntil("charityhomepage", (route) => false);
                                Navigator.of(context).pushNamed("postpage");
                                    },
                                    color: Color.fromARGB(255, 119, 33, 108),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        )),
                              ),
    ]),);
  }}