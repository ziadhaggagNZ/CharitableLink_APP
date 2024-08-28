
import 'package:charitablelink/components/apptextformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:drop_down_list/drop_down_list.dart';

class signupprovider extends StatefulWidget {
  const signupprovider({super.key});

  @override
  State<signupprovider> createState() => _signupproviderState();
}

class _signupproviderState extends State<signupprovider> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController Interests = TextEditingController();


CollectionReference aidprovider = FirebaseFirestore.instance.collection('aidprovider');

//String? aidprovider_username;
//String? aidprovider_email;


@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



      // ignore: non_constant_identifier_names
      Future<void> add_aidprovider(String aidprovider_username , String aidprovider_email ) {
      return aidprovider
          .add({
            'aidprovider_username': aidprovider_username, 
            'aidprovider_email': aidprovider_email, 
            'id' : FirebaseAuth.instance.currentUser!.uid 
          })
          .then((value) => print("aidprovider Added"))
          .catchError((error) => print("Failed to add aidprovider: $error"));
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),child: Container(height: 450 ,width: 450 ,child: Image.asset("images/giving_hart.png",fit: BoxFit.fill,),),),
            Center(child: Container(padding: EdgeInsets.only(top: 50,left: 20 ,right: 20),child: AppTextField(hinttext: "user name",mycontroller: username,),)),
            Center(child: Container(padding: EdgeInsets.only(top: 50,left: 20 ,right: 20),child: AppTextField(hinttext: "email",mycontroller: email,),)),
            Center(child: Container(padding: EdgeInsets.only(top: 50,left: 20 ,right: 20),child: AppTextField(hinttext: "password",mycontroller: password,),)),
               Center(
            child: Container(width: 410,height: 113,
                padding: EdgeInsets.only(left: 20 ,right: 20,top: 50),
                child: MaterialButton(
                  child: Text("Sign up" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25), ),textColor:Colors.white,
                  onPressed: ()async{
                    if(username.text != "" && email.text != "" && password.text != "")
                    {
                    try {
  // ignore: unused_local_variable
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.text,
    password: password.text,
  );
  FirebaseAuth.instance.currentUser!.sendEmailVerification();
  add_aidprovider(username.text, email.text);
  Navigator.of(context).pushReplacementNamed("login");
} 
on FirebaseAuthException catch (e) {
  
   if (e.code == 'email-already-in-use') {
  //  AwesomeDialog(
  //           context: context,
  //           dialogType: DialogType.error,
  //           animType: AnimType.rightSlide,
  //           title: 'email ',
  //           desc: 'email is already exists',
  //           btnOkOnPress: () {},
  //           ).show();
  }
  else if (e.code == 'weak-password') {
  // AwesomeDialog(
  //           context: context,
  //           dialogType: DialogType.error,
  //           animType: AnimType.rightSlide,
  //           title: 'password',
  //           desc: 'weak password',
  //           btnOkOnPress: () {},
  //           ).show();
    } 

} catch (e) {
  print(e);
}
                  }
                  },
                  color: Color.fromARGB(255, 119, 33, 108),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
                  )),
              ),
          ),
          Container(height: 50,),
          ],
        ),
      )
    );
  }
}









// if(username.text != "" && email.text != "" && password.text != "")







//                     try {
//   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: email.text,
//     password: password.text,
//   );
//   FirebaseAuth.instance.currentUser!.sendEmailVerification();
//   add_aidprovider(username.text, email.text);
//   Navigator.of(context).pushReplacementNamed("login");
// } 
// on FirebaseAuthException catch (e) {
  
//    if (e.code == 'email-already-in-use') {
//   //  AwesomeDialog(
//   //           context: context,
//   //           dialogType: DialogType.error,
//   //           animType: AnimType.rightSlide,
//   //           title: 'email ',
//   //           desc: 'email is already exists',
//   //           btnOkOnPress: () {},
//   //           ).show();
//   }
//   else if (e.code == 'weak-password') {
//   // AwesomeDialog(
//   //           context: context,
//   //           dialogType: DialogType.error,
//   //           animType: AnimType.rightSlide,
//   //           title: 'password',
//   //           desc: 'weak password',
//   //           btnOkOnPress: () {},
//   //           ).show();
//     } 

// } catch (e) {
//   print(e);
// }




