//import 'dart:html';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charitablelink/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class needyinfo extends StatefulWidget {
  const needyinfo({super.key});

  @override
  State<needyinfo> createState() => _needyinfoState();
}

class _needyinfoState extends State<needyinfo> {
  TextEditingController money_controller = TextEditingController();
  TextEditingController help_controller = TextEditingController();

  // List<DocumentSnapshot> score = [];

  Map<String, dynamic>? score;

  int? localScore;

  bool loading = true;
  int? localmoney;
  String? score_string;

  DocumentSnapshot? documentSnapshot;

  needy_data(needy_national_id) async {
    data_needy = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("needy")
        .where("needy_national_id", isEqualTo: needy_national_id)
        .get();
    data_needy.addAll(querySnapshot.docs);
    if (data_needy.isEmpty) {
      print("eeeeeeeeeeeeeeeeeeeeeeeee");
      print(needy_national_id);
    } else {
      //Navigator.of(context).pushNamed("needyinfo");

      setState(() {});
      loading = false;
    }
  }

  get_score() async {
    await FirebaseFirestore.instance
        .collection("needy")
        .doc(global_needy_national_id)
        .collection("needy_aid")
        .doc(global_needy_national_id)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        score = documentSnapshot.data();

        setState(() {
          localScore = score?['score'];
        });
      }
    });
  }

  update_score(localScore) async {
    loading = true;
    await FirebaseFirestore.instance
        .collection("needy")
        .doc(global_needy_national_id)
        .collection("needy_aid")
        .doc(global_needy_national_id)
        .update({"score": localScore});
    loading = false;
  }

  add_help(String help) {
    FirebaseFirestore.instance
        .collection("needy")
        .doc(global_needy_national_id)
        .collection("needy_aid")
        .doc(global_needy_national_id)
        .collection("helps")
        .doc()
        .set({
          'charity_publisher_id': FirebaseAuth.instance.currentUser!.uid,
          'needy_national_id': global_needy_national_id,
          'help': help,
        })
        .then((value) => print("post Added"))
        .catchError((error) => print("Failed to add post: $error"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    needy_data(global_needy_national_id);
    get_score();
    setState(() {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Scaffold(
            body: Text("loading......"),
          )
        : Scaffold(
            body: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                    ),

                    Text(
                      "name : ${data_needy.first["name"]}",
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 33, 108),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      "age : ${data_needy.first["age"]}",
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 33, 108),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      "phone : ${data_needy.first["phone"]}",
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 33, 108),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      "address : ${data_needy.first["address"]}",
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 33, 108),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      "national id : ${data_needy.first["needy_national_id"]}",
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 33, 108),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    // score in month
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 90, vertical: 30),
                      //padding: EdgeInsets.only(left: 100),
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 200,
                            width: 200,
                            color: Color.fromARGB(255, 119, 33, 108),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Column(children: [
                                Text(
                                  "score/M",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 20,
                                ),
                                Text(
                                  //"$score_string",
                                  "${score?['score'] == null ? 0 : score?['score']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                          )),
                    ),

                    Container(
                        padding: EdgeInsets.only(left: 15, right: 35),
                        child: Container(
                          width: 400,
                          height: 300,
                          color: Color.fromARGB(255, 119, 33, 108),
                          child: Column(children: [
                            Container(
                              width: 400,
                              height: 100,
                              child: Row(children: [
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 20),
                                    height: 80,
                                    width: 200,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: money_controller,
                                      textAlign: TextAlign.center,
                                      // ignore: prefer_const_constructors
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 119, 33, 108)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 108, 247, 70)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        hintText: "money",
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(left: 0, top: 0),
                                    child: TextButton(
                                        onPressed: () {
                                          if (money_controller.text == "") {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.rightSlide,
                                              title: 'empty',
                                              desc: 'field is empty',
                                              btnOkOnPress: () {},
                                            ).show();
                                          } else {
                                            if (localScore == null) {
                                              localScore = 0;
                                            }

                                            localScore = localScore! +
                                                int.parse(
                                                    money_controller.text);

                                            score_string = "$localScore";
                                            update_score(localScore);

                                            setState(() {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      "charityhomepage",
                                                      (route) => false);
                                              Navigator.of(context)
                                                  .pushNamed("needyinfo");
                                            });
                                          }
                                        },
                                        child: Text(
                                          "Add",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))),
                              ]),
                            ),
                            Container(
                              width: 400,
                              height: 100,
                              child: Row(children: [
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 20),
                                    height: 80,
                                    width: 200,
                                    child: TextFormField(
                                      controller: help_controller,
                                      textAlign: TextAlign.center,
                                      // ignore: prefer_const_constructors
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 119, 33, 108)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 108, 247, 70)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        hintText: "help",
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.only(left: 0, top: 0),
                                    child: TextButton(
                                        onPressed: () {
                                          if (help_controller.text == "") {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.rightSlide,
                                              title: 'empty',
                                              desc: 'field is empty',
                                              btnOkOnPress: () {},
                                            ).show();
                                          } else {
                                            add_help(help_controller.text);
                                             AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.success,
                                              animType: AnimType.rightSlide,
                                              title: 'success',
                                              desc: 'help is Add',
                                              btnOkOnPress: () {},
                                            ).show();
                                            setState(() {
                                              help_controller.text="";
                                            });
                                            
                                          }
                                        },
                                        child: Text(
                                          "Add",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))),
                              ]),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 15, top: 20),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed("needyhelpspage");
                                    },
                                    child: Text(
                                      "View Aid details",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                          ]),
                        ))
                  ],
                )),
          );
  }
}
