import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charitablelink/posts/edit_post.dart';
import 'package:charitablelink/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class postspage extends StatefulWidget {
  const postspage({super.key});

  @override
  State<postspage> createState() => _postspageState();
}

class _postspageState extends State<postspage> {
  // TextEditingController post = TextEditingController();

  // TextEditingController search = TextEditingController();

  bool? loading;

  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  List<QueryDocumentSnapshot> data_posts = [];


  get_posts() async {
    //QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("posts").where("charity_publisher_id" , isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("charity")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("posts")
        .get();
    data_posts.addAll(querySnapshot.docs);
    setState(() {});
    loading = false;
  }

  // ignore: non_constant_identifier_names

  @override
  void initState() {
    get_posts();
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
                itemCount: data_posts.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 100,
                    width: 300,
                    child: InkWell(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.rightSlide,
                          title: 'process',
                          desc: 'edit or delete',
                          btnOkText: "edit",
                          btnOkOnPress: () {
                           data_posts_edit =data_posts;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ediitpost(i: i),));
                          },
                          btnCancelText: "delete",
                          btnCancelOnPress: () {
                            FirebaseFirestore.instance
                                .collection("charity")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("posts").doc(data_posts[i].id).delete();
                                Navigator.of(context).pushReplacementNamed("postpage");
                          },
                        ).show();
                      },
                      child: Card(
                        child: Container(
                          child: Text("${data_posts[i]["post"]}"),
                        ),
                      ),
                    ),
                  );
                }));
  }
}
