







import 'package:charitablelink/aidprovider/aidprovider_homepage.dart';
import 'package:charitablelink/charity/charity_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
 
 
List<QueryDocumentSnapshot> data =[];


 typetest ()
async{
 QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("aidprovider").where("id" , isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      data.addAll(querySnapshot.docs);
      setState(() {
        print("++++++++++++++++");
        print(data.length);
        print(FirebaseAuth.instance.currentUser!.email);
        print("++++++++++++++++");
      });

      
    
}




@override
  void initState() {
    super.initState();
    // TODO: implement initStates
  typetest();
  }


 

  @override
  Widget build(BuildContext context) {
    
     return Scaffold(
       //body:  globals.state == false ? aidprovider_homepage() : charity_homepage(),
       body:  data.length > 0 ? aidprovider_homepage() : charity_homepage(),
       
    );
  }
// @override
//   void deactivate() {
//     // TODO: implement deactivate
//     super.deactivate();
//     typetest();
//   }


}











    // if(testmail.size == 0)
    // {
    //      state = false;
    //     print("-------------------------");
    //     print(state);
    //     print("${FirebaseAuth.instance.currentUser!.email}");
    //     print("-------------------------");
    //   }
    //   else
    //   {
    //     state = true;
    //     print("-------------------------");
    //     print(state);
    //     print("${FirebaseAuth.instance.currentUser!.email}");
    //     print("-------------------------");
    //   }