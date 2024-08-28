//import 'package:charitablelink/components/apptextformfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charitablelink/components/posttextform.dart';
import 'package:charitablelink/components/selectfield.dart';
import 'package:charitablelink/variables.dart';
//import 'package:charitablelink/public.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/foundation.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: camel_case_types
class charity_homepage extends StatefulWidget {
  const charity_homepage({super.key});

  @override
  State<charity_homepage> createState() => _charity_homepageState();
}

// ignore: camel_case_types
class _charity_homepageState extends State<charity_homepage> {
  TextEditingController post = TextEditingController();

  TextEditingController search = TextEditingController();

  TextEditingController posttype_controller = TextEditingController();

//CollectionReference posts = FirebaseFirestore.instance.collection('posts');

//CollectionReference needy = FirebaseFirestore.instance.collection('needy');

  bool loading = true;
  bool loadingdrawer = true;

  bool social = false;
  bool health = false;
  bool disabled = false;
  bool education = false;
  bool orphan = false;
  bool aging = false;


  // add_needy_aid() {
  //   FirebaseFirestore.instance
  //       .collection("needy")
  //       .doc(/*national id*/ )
  //       .collection("needy_aid")
  //       .doc(/*national id*/)
  //       .set({
  //         'score': 0,
  //       })
  //       .then((value) => print("add"))
  //       .catchError((error) => print("Failed to add: $error"));
  // }

  add_post(String post, String Category) {
    


    if (posttype_controller.text == "Social assistance") {
       social = true;
       health = false;
       disabled = false;
       education = false;
       orphan = false;
       aging = false;
    }
    else if (posttype_controller.text == "Disabled care") {
       social = false;
       health = false;
       disabled = true;
       education = false;
       orphan = false;
       aging = false;
    }
else if (posttype_controller.text == "Health and Medical") {
       social = false;
       health = true;
       disabled = false;
       education = false;
       orphan = false;
       aging = false;
    }
    else if (posttype_controller.text == "Education") {
       social = false;
       health = false;
       disabled = false;
       education = true;
       orphan = false;
       aging = false;
    }
    else if (posttype_controller.text == "orphan children care") {
       social = false;
       health = false;
       disabled = false;
       education = false;
       orphan = true;
       aging = false;
    }
    else if (posttype_controller.text == "Aging care") {
       social = false;
       health = false;
       disabled = false;
       education = false;
       orphan = false;
       aging = true;
    }


    FirebaseFirestore.instance
        .collection("charity")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("posts")
        .doc()
        .set({
          'charity_publisher_id': FirebaseAuth.instance.currentUser!.uid,
          'post': post,
           'social' : social, 
           'health' : health, 
          'disabled' : disabled, 
          'education' : education, 
          'orphan' : orphan, 
          'aging' : aging, 
        })
        .then((value) => print("post Added"))
        .catchError((error) => print("Failed to add post: $error"));



  }

  //   Future<void> add_post(String post) {
  //   return posts
  //       .add({
  //         'charity_publisher_id' : FirebaseAuth.instance.currentUser!.uid,
  //         'post': post,
  //       })
  //       .then((value) => print("charity Added"))
  //       .catchError((error) => print("Failed to add charity: $error"));
  // }

  // ignore: non_constant_identifier_names
  //List data_charity =[];

  List<QueryDocumentSnapshot> data_charity = [];

  // ignore: non_constant_identifier_names
  get_charity_data() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("charity")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data_charity.addAll(querySnapshot.docs);
    setState(() {});
    loading = false;
    loadingdrawer = false;
  }

  // List<QueryDocumentSnapshot> data_needy = [];

  needy_search(needy_national_id) async {
    data_needy = [];
    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //     .collection("needy")
    //     .doc(needy_national_id)
    //     .collection("needy_data")
    //     .get();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("needy")
        .where("needy_national_id", isEqualTo: needy_national_id)
        .get();
    data_needy.addAll(querySnapshot.docs);
    if (data_needy.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'not found',
        desc: '${needy_national_id} not found',
        btnOkOnPress: () {},
        btnCancelText: "add new needy",
        btnCancelOnPress: () {
          Navigator.of(context).pushNamed("addneedy");
        },
      ).show();
    } else {
      Navigator.of(context).pushNamed("needyinfo");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_charity_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: loadingdrawer == true
            ? Text("loading......")
            : Drawer(
                child: ListView(children: [
                  Container(
                    height: 10,
                  ),
                  Container(
                    //padding: EdgeInsets.only(left: 0),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "images/charity2.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "${data_charity.first["charity_username"]}",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 119, 33, 108),
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "${FirebaseAuth.instance.currentUser!.email}",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 119, 33, 108),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  ListTile(
                    title: Text(
                      "Add needy",
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 33, 108),
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.person_add_alt_1_sharp,
                      color: Color.fromARGB(255, 119, 33, 108),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("addneedy");
                    },
                  ),
                  ListTile(
                    title: Text(
                      "posts",
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 33, 108),
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.post_add_outlined,
                      color: Color.fromARGB(255, 119, 33, 108),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "postpage",
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      "log out",
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 33, 108),
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.login_outlined,
                      color: Color.fromARGB(255, 119, 33, 108),
                    ),
                    onTap: () async {
                      GoogleSignIn googleSignIn = GoogleSignIn();
                      if (googleSignIn.isSignedIn() == true) {
                        googleSignIn.disconnect();
                      }
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("login", (route) => false);
                    },
                  ),
                ]),
              ),
        appBar: AppBar(),
        body: loading == true
            ? Text("loading......")
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 400,
                      height: 461,
                      child: Card(
                          child: Column(
                        children: [
                          Text(
                            "${data_charity.first["charity_username"]}",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 119, 33, 108)),
                          ),
                          Image.asset(
                            "images/charity2.png",
                            fit: BoxFit.fill,
                          ),
                        ],
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 100,
                      child: Card(
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10),
                                width: 280,
                                child: postTextField(
                                    mycontroller: search, hintText: "search (national ID)")),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    global_needy_national_id = search.text;
                                  });
                                  needy_search(search.text);
                                },
                                icon: Icon(Icons.search))
                          ],
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                            ),
                            postTextField(mycontroller: post, hintText: "post"),
                           
                            AppTextField(
                              textEditingController: posttype_controller,
                              title: " ",
                              hint: "post type",
                              isCitySelected: true,
                              cities: [
                                SelectedListItem(name: "Social assistance"),
                                SelectedListItem(name: "Disabled care"),
                                SelectedListItem(name: "Health and Medical"),
                                SelectedListItem(name: "Education"),
                                SelectedListItem(name: "orphan children care"),
                                SelectedListItem(name: "Aging care"),
                              ],
                            ),

                            Container(
                              width: 200,
                              height: 113,
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 20),
                              child: MaterialButton(
                                  child: Text(
                                    "Add post",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  textColor: Color.fromARGB(255, 119, 33, 108),
                                  onPressed: () {
                                    if (post.text == "") {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.rightSlide,
                                        title: 'post',
                                        desc: 'post fiels is empty',
                                        btnOkOnPress: () {},
                                      ).show();
                                    } else {
                                      add_post(post.text,posttype_controller.text);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              "charityhomepage",
                                              (route) => false);
                                    }
                                  },
                                  color: Color.fromARGB(255, 119, 33, 108),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                            ),

                            // Container(
                            //   height: 20,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    //Text("${data_posts.length}"),
                  ],
                ),
              ));
  }
}
