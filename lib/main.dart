import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './post_model.dart';
import './second.dart';
import 'dart:io';
import 'my_flutter_app_icons.dart';
void main() => runApp(new LoginApp());

class LoginApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SpimoLung LogIn'),
//      routes: routes,
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

  void _showDialog(String param){
    print("showDialog param: ");
    print(param);
    if(param == '-1'){
      showDialog(
          context:context,
          builder: (BuildContext context){
            return AlertDialog(
              content: new Text("Patient and Device ID can't be empty."),
              actions: <Widget>[
                new FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: new Text("OK"),
                )//FlatButton
              ],
            );
          }//builder
      ); //showDialog
    }else if(param=='0'){
      showDialog(
          context: context,
          builder: (BuildContext context ){
            return AlertDialog(
              content: new Text("Patient or Device ID already registed. Please enter your ID again."),
              actions: <Widget>[
                new FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: new Text("OK")
                ),
              ]
            );
          }
      );
    }else if (param=='2'){
      showDialog(
          context: context,
          builder: (BuildContext context ){
            return AlertDialog(
                content: new Text("Not Valid Device id. Please enter again"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: new Text("OK")
                  ),
                ]
            );
          }
      );
    }else if(param=='1'){
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new SecondPage(patient: loginController.text,spimo: spimoController.text,pedal:pedalController.text)),
      );
    }

  }
  String _res_body='';

  void loginIn(String patient_id, String spimo_id, String pedal_id,String secondUrl) {
    if(patient_id.isEmpty || spimo_id.isEmpty ||pedal_id.isEmpty ||passwordController.text.isEmpty){
      print("please enter your patient id and device id");
      _showDialog("-1");

    }else {
      print("patient: " + patient_id);
      print("spimo_id: " + spimo_id);
      print("pedal_id: "+pedal_id);
      _res_body = postData(patient_id,spimo_id,pedal_id,secondUrl);
      _showDialog("1");
    //_showDialog(_res_body);  //0: duplicate, 1: success, 2: no device
    }
  }

  var loginController = new TextEditingController();
  var spimoController = new TextEditingController();
  var pedalController = new TextEditingController();
  var passwordController = new TextEditingController();




@override

  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: new Text(
          widget.title,
          style: new TextStyle(
            color:Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),

        child: ListView(
//      child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(
            height: 100,
          width: 300.0,

        ),


              new SizedBox(
                height:50.0,
                width:300.0,
                child: new TextField(
                  enabled:true,
                  keyboardType: TextInputType.text,
                  maxLines:1,
                  maxLength: 8,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  controller: loginController,
//                  onChanged: (v) => loginController.text = v,
                  decoration: new InputDecoration(
                    hintText: 'Your Patient ID (PAT001)',
                    icon: new Icon(
//                      Icons.person,
                    Icons.assignment_ind,
                      color:Colors.black,
                    ),
                  ),
                ),
               ),//SizedBox
              new SizedBox(
                height:50.0,
                width:300.0,
                child: new TextField(
                  enabled:true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLines:1,
                  maxLength: 8,
                  autofocus: false,
                  controller: spimoController,
//                  onChanged: (v) => spimoController.text=v,
                  decoration: new InputDecoration(
                    hintText: 'Your spirometer ID (SPI001)',
                    icon: new Icon(
                      MyFlutterApp.lung,
                      color:Colors.black,
                    ),
                  ),
                ),
              ),//SizedBox

            new SizedBox(
              height:50.0,
              width:300.0,
              child: new TextField(
                enabled:true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLines:1,
                maxLength: 8,
                autofocus: false,
                controller: pedalController,
//                onChanged: (v) => pedalController.text=v,
                decoration: new InputDecoration(
                  hintText: 'Your pedal ID (PED001)',
                  icon: new Icon(
                    Icons.airline_seat_legroom_extra,
                    color:Colors.black,
                  ),
                ),
              ),
            ),//SizedBox

            new SizedBox(
              height:50.0,
              width:300.0,
              child: new TextField(
                enabled:true,
                keyboardType: TextInputType.text,
                maxLines:1,
                maxLength: 8,
                autofocus: false,
                controller: passwordController,
                textInputAction: TextInputAction.send,

//                onChanged: (v) => passwordController.text=v,
                obscureText: true,
                decoration: new InputDecoration(
                  hintText: 'Your Patient Password',
                  icon: new Icon(
                    MyFlutterApp.lock,
                    color:Colors.black,
                  ),
                ),
              ),
            ),//SizedBox

            //Log in
              const SizedBox(height:40),
                RaisedButton(
                onPressed: () => loginIn(loginController.text,spimoController.text,pedalController.text,"register_device"),//(){
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize:20),
                  ),
                ),
            ],
        ),
        ),
      ),

    );
  }

  void dispose(){
    loginController.dispose();
    super.dispose();
  }
}

