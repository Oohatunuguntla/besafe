import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:besafe/landingscreen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Contactinfo extends StatefulWidget{
  @override
  State<StatefulWidget>createState(){

    return Contactinfostate();
  }
}
class Contactinfostate extends State<Contactinfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
 
  String _emergencynumber;
  String _familynumber1;
  String _familynumber2;
 

  TextEditingController passWordController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return WillPopScope(
      child: Scaffold(
             appBar: PreferredSize(
         preferredSize: Size.fromHeight(100.0),
      child: AppBar(
              centerTitle: true,
              title: Text('Be Safe'),
              
              leading: IconButton(icon: Image.asset('images/logo.png'), onPressed: null),
      )),
        body: _getbody(),
      ),
      onWillPop: (){

        debugPrint('Exitingg Contact page');
        Navigator.of(context).pop();
      },
    );
  }
  Widget _getbody(){
    
      return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      'Contact details',
                      style: TextStyle(
                          //fontSize: 40,
                          //fontFamily: 'TooneyNoodle',
                          color: Colors.lime),
                      textAlign: TextAlign.center,
                    ),
                  ),

                 
                  // Emergencynumber...
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: TextFormField(
                      
                      textAlign: TextAlign.justify,
                      cursorRadius: Radius.circular(5),
                      cursorColor: Colors.grey,
                      autocorrect: true,
                      keyboardAppearance: Brightness.dark,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        labelText: 'Emergencynumber',
                        hintText: 'Enter phone number to contact in emergency',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Emergencynumber can\'t be empty';
                        }
                        
                        return null;
                      },
                      onSaved: (value) {
                        _emergencynumber = value;
                      },
                    ),
                  ),

                 

                  // Familynumber1...
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.only(top: 30),
                    child: TextFormField(
                     
                      textAlign: TextAlign.justify,
                      cursorRadius: Radius.circular(5),
                      cursorColor: Colors.grey,
                      keyboardAppearance: Brightness.dark,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        labelText: 'Family or friend number',
                        hintText: 'Phone number for messaging them in danger',
                      ),
                      
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Phonenumber can\'t be null';
                        }
                        
                        
                      },
                      onSaved: (value) {
                        _familynumber1 = value;
                      },
                    ),
                  ),

                  // Familynumber2
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.only(top: 30),
                    child: TextFormField(
                      textAlign: TextAlign.justify,
                      cursorRadius: Radius.circular(5),
                      cursorColor: Colors.grey,
                      keyboardAppearance: Brightness.dark,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        labelText: 'Family or friend number',
                        hintText: 'Phone number for messaging them in danger',
                      ),
                      
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Phonenumber didn\'t match';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _familynumber2 = value;
                      },
                    ),
                  ),
                  // Save Button...
                  Container(
                      width: 350,
                      margin: EdgeInsets.only(top: 30, bottom: 40),
                      child: RaisedButton(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          debugPrint('pressed Save button!');
                          _validateAndSubmit();
                        },
                        color: Colors.lime,
                      )),

                
                ],
              ),
            ),
          ],
        ),
      );
    }
    bool _validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    if (_validateAndSave()) {
      debugPrint('Validated the form');
      
      try {
        
         var url="http:// 192.168.29.209:5000/contactdetails_save";
         print(url);
		final _auth=FirebaseAuth.instance;
		final FirebaseUser user=await _auth.currentUser();
		var uid=user.uid;
    http.Response resp = await http.post(url,body: {'uid':uid,'emergencynumber':_emergencynumber,'familynumber1':_familynumber1,'familynumber2':_familynumber2});  // 10.0.2.2 for emulator
    if (resp.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(resp.body);
      print('$jsonResponse');
        Navigator.push(context,MaterialPageRoute(builder:(context)=>LandingApp()));
    }
    else{
      print("fail");
      // Navigator.of(context).pushNamed('/main');
    }
      } catch (error) {
        print('error: $error');
        _showAlertDialog('Error', error.toString());
        
      }
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) {
          return alertDialog;
        });
  }


}