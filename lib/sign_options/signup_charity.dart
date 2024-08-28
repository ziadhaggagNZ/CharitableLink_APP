import 'package:charitablelink/components/apptextformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class signupcharity extends StatefulWidget {
  const signupcharity({super.key});

  @override
  State<signupcharity> createState() => _signupcharityState();
}

class _signupcharityState extends State<signupcharity> {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

bool social =false;
bool health =false;
bool disabled =false;
bool education =false;
bool orphan =false;
bool aging =false;



CollectionReference charity = FirebaseFirestore.instance.collection('charity');



      // ignore: non_constant_identifier_names
    //   Future<void> add_charity(String charity_username , String charity_email,bool social ,bool health ,bool disabled,bool education,bool orphan ,bool aging ,) {
    //   return charity
    //       .add({
    //         'id' : FirebaseAuth.instance.currentUser!.uid,
    //         'charity_username': charity_username, 
    //         'charity_email': charity_email, 
    //         'social' : social,
    //         'health' : health,
    //         'disabled' : disabled,
    //         'education' : education,
    //         'orphan' : orphan,
    //         'aging' : aging,
    //       })
    //       .then((value) => print("charity Added"))
    //       .catchError((error) => print("Failed to add charity: $error"));
    // }



  add_charity(String charity_username , String charity_email,bool social ,bool health ,bool disabled,bool education,bool orphan ,bool aging ,) {
     
      FirebaseFirestore.instance
      .collection("charity")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
            'id' : FirebaseAuth.instance.currentUser!.uid,
            'charity_username': charity_username, 
            'charity_email': charity_email, 
            'social' : social,
            'health' : health,
            'disabled' : disabled,
            'education' : education,
            'orphan' : orphan,
            'aging' : aging,
          })
          .then((value) => print("charity Added"))
          .catchError((error) => print("Failed to add charity: $error"));
    }

    


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(child: Container(height: 450 ,width: 450 ,child: Image.asset("images/charity.png",fit: BoxFit.fill,),),),
            Center(child: Container(padding: EdgeInsets.only(top: 50,left: 20 ,right: 20),child: AppTextField(hinttext: "charity name",mycontroller: username,),)),
            Center(child: Container(padding: EdgeInsets.only(top: 50,left: 20 ,right: 20),child: AppTextField(hinttext: "email",mycontroller: email,),)),
            Center(child: Container(padding: EdgeInsets.only(top: 50,left: 20 ,right: 20),child: AppTextField(hinttext: "password",mycontroller: password,),)),
        

            Container(height: 50,),

                            Container(
                  width: 500,
                 // padding: EdgeInsets.only(left: 1),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(  
                                checkColor: Color.fromARGB(255, 119, 33, 108),  
                                activeColor: Colors.greenAccent,  
                                value: this.social,  
                                onChanged: (value) {  
                                  setState(() {  
                                    this.social = value!;  
                                  });  
                                },  
                              ),
                              
                          Text("Social assistance"),
                        ],
                      ),
                      Container(width: 30 ,),
                   Row(
                        children: [
                      
   Checkbox(  
                                checkColor: Color.fromARGB(255, 119, 33, 108),  
                                activeColor: Colors.greenAccent,  
                                value: this.disabled,  
                                onChanged: (value) {  
                                  setState(() {  
                                    this.disabled = value!;  
                                  });  
                                },  
                              ),
                              
                          Text("Disabled care"),                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 500,
                 // padding: EdgeInsets.only(left: 1),
                  child: Row(
                    children: [
                      Row(
                        children: [
                             Checkbox(  
                                checkColor: Color.fromARGB(255, 119, 33, 108),  
                                activeColor: Colors.greenAccent,  
                                value: this.health,  
                                onChanged: (value) {  
                                  setState(() {  
                                    this.health = value!;  
                                  });  
                                },  
                              ),
                                  Text("Health and Medical "),



                       
                        ],
                      ),
                      Container(width: 15 ,),
                   Row(
                        children: [
                      
                          Checkbox(  
                                checkColor: Color.fromARGB(255, 119, 33, 108),  
                                activeColor: Colors.greenAccent,  
                                value: this.education,  
                                onChanged: (value) {  
                                  setState(() {  
                                    this.education = value!;  
                                  });  
                                },  
                              ),
                                  Text("Education "),
                        ],
                      ),
                    ],
                  ),
                ),  

            Container(
              width: 500,
              child: Row(
                    children: [
                      Row(
                        children: [
                          
                          Checkbox(  
                                checkColor: Color.fromARGB(255, 119, 33, 108),  
                                activeColor: Colors.greenAccent,  
                                value: this.orphan,  
                                onChanged: (value) {  
                                  setState(() {  
                                    this.orphan = value!;  
                                  });  
                                },  
                              ),
                              Text("orphan children care"),
                        ],
                      ),
                      Container(width: 12,),
                     Row(
                        children: [
                         
                          Checkbox(  
                                checkColor: Color.fromARGB(255, 119, 33, 108),  
                                activeColor: Colors.greenAccent,  
                                value: this.aging,  
                                onChanged: (value) {  
                                  setState(() {  
                                    this.aging = value!;  
                                  });  
                                },  
                              ),
                               Text("Aging care"),
                        ],
                      ),
                    ],
                  ),
            ),

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
 add_charity(username.text, email.text, social, health, disabled, education, orphan, aging);
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

