import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:besafe/contactinfo.dart';
void main() {
  runApp(LandingApp());
}

void _sendsms(String message,List<String>recipents) async{
  String _result=await sendSMS(message: message,recipients: recipents)
      .catchError((onError){
        print(onError);
      });
      print(_result);
}
// _phonecall() async{
//   const url='tel:7382642568';
//   print('making call');
//   if(await canLaunch(url)){
//     await launch(url);
//   }
//   else{
//     throw 'couldnot call $url';
//   }
// }
_directphonecall() async{
  const number='7382642568';
  bool res=await FlutterPhoneDirectCaller.callNumber(number);
}
class LandingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Be Safe',
      theme: ThemeData(

        primarySwatch: Colors.lime,
              visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Be Safe')
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget getWidget(path,text){
    return Expanded(
      child:Column(
        children: <Widget>[
          //InkWell(
             
           // onTap:()=>_sendsms('hiii',['7382642568','9989383223']),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40.0,
            child: ClipOval(
             child:Image.asset(path),
            ),
          ),
         // ),
          Text(text,style:TextStyle(
            fontSize: 20.0,
            color: Colors.red
          ))
    ],
    ),
    );
  }
 

  Widget build(BuildContext context) {
     return Scaffold(
       appBar: PreferredSize(
         preferredSize: Size.fromHeight(100.0),
      child: AppBar(
              centerTitle: true,
              title: Text(widget.title),
              
              leading: IconButton(icon: Image.asset('images/logo.png'), onPressed: null),
      )),
      body:Container(
        decoration:BoxDecoration(
          gradient:LinearGradient(
            colors:[
          
              Colors.blue[400],
              Colors.green[200],
              Colors.purple[100]
              
            ],
            begin:Alignment.bottomLeft,
            end:Alignment.topRight
            ),
        ),
        child: Column(
          children: [
             SizedBox(height: 200,width: 70,),
            Column(
             
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                 //SizedBox(height: 100,width: 100,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    SizedBox(height: 20,width: 3),
                    InkWell(onTap: () => _directphonecall(),
                    child:getWidget('images/call100.jpg','Call police'),
                    ),
                    InkWell(onTap: ()=>_sendsms('hi', ['9840290558','9989383223']),
                    child:getWidget('images/call100.jpg','Mesage family'),
                    )
                    
                    
                          ],
                    ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    SizedBox(height: 250,width: 3),
                    InkWell(onTap:()=>_directphonecall(),
                    child:getWidget('images/call100.jpg','Emergency Call'),
                    ),
                    InkWell(onTap:()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Contactinfo())),
                    child:getWidget('images/call100.jpg','Update contact details'),
                    )
                            ],
                     ),
              ]
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children:[
            //     getWidget('images/call100.jpg','Call 100'),
            //     getWidget('images/call100.jpg','Call 100'),
            //     getWidget('images/call100.jpg','Call 100'),
            //     getWidget('images/call100.jpg','Call 100')
            //   ],
            // )

        ],),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
