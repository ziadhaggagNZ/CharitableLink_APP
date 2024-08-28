import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charitablelink/components/apptextformfield.dart';
import 'package:charitablelink/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNeedy extends StatefulWidget {
  const AddNeedy({super.key});

  @override
  State<AddNeedy> createState() => _AddNeedyState();
}





class _AddNeedyState extends State<AddNeedy> {


add_needy_aid(needy_national_id) async
  {
  await  FirebaseFirestore.instance
        .collection("needy")
        .doc(needy_national_id )
        .collection("needy_aid")
        .doc(needy_national_id)
        .set({
          'score': 0,
        });
  }





  needy_add(needy_national_id, name, age, phone, address) async {
    await FirebaseFirestore.instance
        .collection("needy")
        .doc(needy_national_id)
        .set({
      'needy_national_id': needy_national_id,
      'name': name,
      'age': age,
      'phone': phone,
      'address': address,
    });
    add_needy_aid(needy_national_id);
  }


  
  TextEditingController needy_national_id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                    children: [
            Container(
              height: 100,
            ),
            AppTextField(
                hinttext: "national id", mycontroller: needy_national_id),
              Container(height: 30,),  
            AppTextField(hinttext: "name", mycontroller: name),
            Container(height: 30,),
            AppTextField(hinttext: "age", mycontroller: age),
            Container(height: 30,),
            AppTextField(hinttext: "phone", mycontroller: phone),
            Container(height: 30,),
            AppTextField(hinttext: "address", mycontroller: address),
            Container(height: 30,),
            Center(
              child: Container(
                width: 250,
                height: 113,
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: MaterialButton(
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 25,),
                      
                    ),
                    textColor: Color.fromARGB(255, 119, 33, 108),
                    onPressed: () {
                      if (needy_national_id.text == "" &&
                          name.text == "" &&
                          age.text == "" &&
                          phone.text == "" &&
                          address.text == "") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'empty',
                          desc: 'field is empty',
                          btnOkOnPress: () {},
                        ).show();
                      }
                      else
                      {
                        setState(() {
                          global_needy_national_id = needy_national_id.text ;
                        });
                        
                      needy_add(needy_national_id.text, name.text, age.text,
                          phone.text, address.text);
                      Navigator.of(context).pushNamedAndRemoveUntil("charityhomepage", (route) => false);  
                      Navigator.of(context).pushNamed("needyinfo");
                      }
            
                    },
                    color: Color.fromARGB(255, 119, 33, 108),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: Color.fromARGB(255, 119, 33, 108),
                        ))),
              ),
            ),
                    ],
                  ),
          )),
    );
  }
}
