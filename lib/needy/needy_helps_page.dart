//import 'package:awesome_dialog/awesome_dialog.dart';
//import 'package:charitablelink/posts/edit_post.dart';
import 'package:charitablelink/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class needy_helps_page extends StatefulWidget {
  const needy_helps_page({super.key});

  @override
  State<needy_helps_page> createState() => _postspageState();
}

class _postspageState extends State<needy_helps_page> {
  // TextEditingController post = TextEditingController();

  // TextEditingController search = TextEditingController();

  bool? loading;

  CollectionReference helps = FirebaseFirestore.instance.collection('helps');

  List<QueryDocumentSnapshot> data_helps = [];


  get_helps() async {
    //QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("posts").where("charity_publisher_id" , isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("needy")
        .doc(global_needy_national_id)
        .collection("needy_aid")
        .doc(global_needy_national_id)
        .collection("helps")
        .get();
    data_helps.addAll(querySnapshot.docs);
    setState(() {});
    loading = false;
  }

  // ignore: non_constant_identifier_names

  @override
  void initState() {
    get_helps();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading == true
            ? Text("loading......")
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data_helps.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 100,
                    width: 300,
                    child: InkWell(
                      // onTap: () {
                      //   AwesomeDialog(
                      //     context: context,
                      //     dialogType: DialogType.question,
                      //     animType: AnimType.rightSlide,
                      //     title: 'process',
                      //     desc: 'edit or delete',
                      //     btnOkText: "edit",
                      //     btnOkOnPress: () {
                      //      data_posts_edit =data_helps;
                      //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ediitpost(i: i),));
                      //     },
                      //     btnCancelText: "delete",
                      //     btnCancelOnPress: () {
                      //       FirebaseFirestore.instance
                      //           .collection("charity")
                      //           .doc(FirebaseAuth.instance.currentUser!.uid)
                      //           .collection("posts").doc(data_helps[i].id).delete();
                      //           Navigator.of(context).pushReplacementNamed("postpage");
                      //     },
                      //   ).show();
                      // },
                      child: Card(
                        child: Container(
                          child: Text("${data_helps[i]["help"]}"),
                        ),
                      ),
                    ),
                  );
                }));
  }
}
