

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactdetailsApp extends StatefulWidget{
   
    @override
    _ContactdetailsAppState createState()=>_ContactdetailsAppState();
}
class _ContactdetailsAppState extends State<ContactdetailsApp>{
  String emergencynumber;
  //final ref=FirebaseDatabase.instance.reference();
  //final emergencycontroller=TextEditingController();
  void _savedatabase(String emergencynumber) async{
   final _auth=FirebaseAuth.instance;
   final FirebaseUser user=await _auth.currentUser();
   var uid=user.uid;
//https://besafe-de68a-default-rtdb.firebaseio.com/
//FirebaseDatabase database=FirebaseDatabase.getInstance();
 //DatabaseReference ref=FirebaseDatabase.getInstance().getReference('https://besafe-de68a-default-rtdb.firebaseio.com/');
 //FirebaseFirestore firestore=FirebaseFirestore.instance;
   final databaseReference=FirebaseDatabase.instance.reference();
   databaseReference.child('$uid').set({
     'emergencynumber':emergencynumber
   });

  }
  @override
  void _initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context){

     return Scaffold(
       appBar: PreferredSize(
         preferredSize: Size.fromHeight(100.0),
      child: AppBar(
              centerTitle: true,
              title: Text('Be Safe'),
              
              leading: IconButton(icon: Image.asset('images/logo.png'), onPressed: null),
      )),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child:Column(children: <Widget>[
          TextField(
            onChanged: (text){
              emergencynumber=text;
            }
          ),
          RaisedButton(onPressed: () => _savedatabase(emergencynumber),
          child:Text('Save')
          )
        ],)
      )
     );
    
}
}